<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use App\Models\Area;
use App\Models\AreaDisabledDay;
use App\Models\Reservation;
use App\Models\Unit;

class ReservationController extends Controller
{
    public function getReservations()
    {

        $daysHelper = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];

        $areas = Area::where('allowed', 1)->get();

        foreach ($areas as $area) {
            $dayList = explode(',', $area['days']);

            $daysGroups = [];

            //Adicionando primeiro dia.
            $lastDay =  intval(current($dayList));
            $daysGroups[] = $daysHelper[$lastDay];
            array_shift($dayList);
            //Adicionando Dias Relevantes
            foreach ($dayList as $day) {
                if (intval($day) != $lastDay + 1) {
                    $daysGroups[] = $daysHelper[$lastDay];
                    $daysGroups[] = $daysHelper[$day];
                }

                $lastDay = intval($day);
            }


            //Adicionado o ultimo dia
            $daysGroups[] = $daysHelper[end($dayList)];

            //Juntando as datas
            $dates = '';
            $close = 0;
            foreach ($daysGroups as $group) {
                if ($close === 0) {
                    $dates .= $group;
                } else {
                    $dates .= '-' . $group . ',';
                }

                $close = 1 - $close;
            }

            $dates = explode(',', $dates);
            array_pop($dates);

            //Adicionando o Time
            $start = date('H:i', strtotime($area['start_time']));
            $end = date('H:i', strtotime($area['end']));

            foreach ($dates as $dKey => $dValue) {
                $dates[$dKey] .= ' ' . $start . ' ás ' . $end;
            }

            $array['list'][] = [
                'id' => $area['id'],
                'cover' => asset('storage/' . $area['cover']),
                'title' => $area['title'],
                'dates' => $dates
            ];
        }
        return $array;
    }

    public function setReservation($id, Request $request)
    {
        $array = ['error' => '']; //inicio Array

        $validator = Validator::make($request->all(), [
            'date' => 'required|date_format:Y-m-d',
            'time' => 'required|date_format:H:i:s',
            'property' => 'required'
        ]);
        if (!$validator->fails()) {
            $date = $request->input('date');
            $time = $request->input('time');
            $property = $request->input('property');

            $unit = Unit::find($property);
            $area = Area::find($id);

            if ($unit && $area) {
                $can = true;

                $weekday = date('w', strtotime($date));

                //Verificar se esta dentro da disponibilidade Padrao
                $allowedDays = explode(',', $area['days']);
                if (!in_array($weekday, $allowedDays)) {
                    $can = false;
                } else {
                    $start = strtotime($area['start_time']);
                    $end = strtotime('-1 hour', strtotime($area['end_time']));
                    $revtime = strtotime($time);
                    if ($revtime < $start || $revtime > $end) {
                        $can = false;
                    }
                }

                //Verificar se esta dentro dos DisabledDays
                $existingDisabledDay = AreaDisabledDay::where('id_area', $id)
                    ->where('day', $date)
                    ->count();
                if ($existingDisabledDay > 0) {
                    $can = false;
                }

                //Verificar se nao existe outra reserva mesmo dia e hora.
                $existingReservation = Reservation::where('id_area', $id)
                    ->where('reservation_date', $date . ' ' . $time)
                    ->count();
                if ($existingReservation > 0) {
                    $can = false;
                }

                if ($can) {
                    $newReservation = new Reservation();
                    $newReservation->id_unit = $property;
                    $newReservation->id_area = $id;
                    $newReservation->reservation_date = $date . ' ' . $time;
                    $newReservation->save();
                } else {
                    $array['error'] = 'Reserva nao permitida neste dia e horario.';
                    return $array;
                }
            } else {
                $array['error'] = 'Dados incorretos';
                return $array;
            }
        } else {
            $array['error'] = $validator->errors()->first();
            return $array;
        }
        return $array; //fim  array inicio do projeto
    }

    public function getDisabledDates($id)
    {
        $array = ['error' => '', 'list' => []];

        $area = Area::find($id);
        if ($area) {

            //Dias Disable Padrao
            $disabledDays = AreaDisabledDay::where('id_area', $id)->get();
            foreach ($disabledDays as $disabledDay) {
                $array['list'][] = $disabledDay['day'];
            }
            //Dias disabled atraves do allowed
            $allowedDays = explode(',', $area['days']);
            $offDays = [];
            for($q=0;$q<7;$q++) {
                if(!in_array($q, $allowedDays)){
                    $offDays[]= $q;
                }
            }

            //Listar os dias proibidos 3 meses pra frente
            $start  = time();
            $end = strtotime('+3 months');
           
            for(
                $current = $start;
                $current < $end;
                $current = strtotime('+1 day', $current)
            ) {
                $wd = date('w', $current);
                if(in_array($wd, $offDays)){
                    $array['list'][] = date('Y-m-d', $current);
                }
            }

        } else {
            $array['error'] = 'Area inexistente';
            return $array;
        }
        return $array;
    }

    public function getTimes($id, Request $request){
        $array = ['error' => ''];

        $validator = Validator::make($request->all(), [
            'date' => 'required|date_format:Y-m-d'
        ]);
        if(!$validator->fails()){
            $date = $request->input('date');
            $area = Area::find($id);

            if($area){

                $can = true;

                //Verificar se e dia disabled
                $existingDisabledDay = AreaDisabledDay::where('id_area', $id)
                ->where('day', $date)
                ->count();
                if($existingDisabledDay > 0){
                    $can = false;
                }

                //Veridicar se e dia permitido

                $allowedDays = explode(',', $area['days']);
                $weekday = date('w', strtotime($date));
                if(!in_array($weekday, $allowedDays)){
                    $can = false;
                }

                if($can){
                    $start = strtotime($area['start_time']);
                    $end = strtotime($area['end_time']);
                    $time = [];

                    for(
                        $lastTime = $start;
                        $lastTime < $end;
                        $lastTime = strtotime('+1 hour', $lastTime)
                    ) {

                        $times[] = $lastTime;
                    }
                    
                    $timeList = [];
                    foreach ($times as $time) {
                        $timeList[]= [
                            'id' => date('H:i:s', $time),
                            'title' => date('H:i', $time). ' - ' .date('H:i', strtotime('+1 hour', $time))
                        ];
                    }
                    //Removendo as reservas
                    $reservations = Reservation::where('id_area', $id)
                    ->whereBetween('reservation_date', [
                        $date.'00:00:00',
                        $date.'23:59:59'
                    ])
                    ->get();

                    $toRemove = [];
                    foreach ($reservations as $reservation) {
                       $time = date('H:i:s', strtotime(($reservation['reservation_date'])));
                       $toRemove[] = $time;
                    }

                    foreach ($timeList as $timeItem) {
                       if(!in_array($timeItem['id'], $toRemove)){
                           $array['list'][] = $timeItem;
                       }
                    }


                    //$array['list'] = $timeList;

                }

            } else {
                $array['error'] = 'Area Inexistente';
                return $array;
            }

        } else {
            $array['error'] = $validator->errors()->first();
        }

        return $array;
    }

    public function getMyReservations(Request $request){
        $array = ['error' => '', 'list' => []];

        $property = $request->input('property');
        if($property){
            $unit = Unit::find($property);
            if($unit){

                $reservations = Reservation::where('id_unit', $property)
                ->orderBy('reservation_date', 'DESC')
                ->get();

                foreach ($reservations as $reservation) {
                    $area = Area::find($reservation['id_area']);

                    $daterev = date('d/m/Y H:i', strtotime($reservation['reservation_date']));
                    $afterTime = date('H:i', strtotime('+1 hour', strtotime($reservation['reservation_date'])));
                    $daterev .= ' à '.$afterTime;

                    $array['list'][] = [
                        'id' => $reservation['id'],
                        'id_area' => $reservation['id_area'],
                        'title' => $area['title'],
                        'cover' => asset('storage/'.$area['cover']),
                        'datereserved' =>$daterev
                    ];

                }
                

            }else {
            
                $array['error'] = 'Propriedade e Inexistente';
                return $array;
            }

        }else {
             $array['error'] = 'Propriedade e necessaria';
            return $array;
        }

        return $array;
    }

    public function delMyReservation($id){
        $array = ['error' => ''];
        
        $user = auth()->user();
        $reservation = Reservation::find($id);
        if($reservation){
            
            $unit = Unit::where('id', $reservation['id_unit'])
            ->where('id_owner', $user['id'])
            ->count();

            if($unit > 0){
                Reservation::find($id)->delete();
            } else {
                $array['error'] = 'Esta reserva nao é sua';
                return $array;
            }

        } else {
            $array['error'] = 'Reserva Inexistente';
            return $array;
        }

        return $array;
    }
}
