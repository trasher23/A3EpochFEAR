
private["_aa","_ab","_ac","_ad","_ae","_af","_ag","_ah","_ai","_aj","_ak","_al","_am","_an","_ao","_ap","_aq","_ar","_as","_at","_au","_av","_aw","_ax","_ay","_az","_aj","_aab","_aac","_aad","_aae","_aaf","_aag","_aah","_aai","_aaj","_aak","_aal","_aam"];_aa=true;if(typename _this=="ARRAY")then{_ab=_this select 0;_ac=call EPOCH_fn_InstanceID;_ad=owner _ab;if(!isNull _ab)then{_ae=getPlayerUID _ab;if(!isNil "_ae" && _ae !="")then{_af=["Player",_ae]call EPOCH_server_hiveGET;_ag=[];if((_af select 0)==1 && typeName(_af select 1)=="ARRAY")then{_ag=(_af select 1);};_ah="U_Test1_uniform";_ai="Epoch_Male_F";_aj="V_41_EPOCH";if((_this select 1)==1)then{_ah="U_Test_uniform";_ai="Epoch_Female_F";_aj="V_F41_EPOCH";};if(count _ag < 11)then{_ag=[[0,[],_ac],[0,0,1,0,[]],["","",_aj,"",_ah,_ai],[""],EPOCH_defaultVars_SEPXVar,["",[]],["ItemMap"],[],[],[],"",true];};_am=_ag select 0;_an=_am select 0;_ao=_am select 1;_ap=_am select 2;_ak=_ag select 1;_aq=_ag select 10;_ar=_ag select 11;_as=_ag select 4;_at=_as select 11;_deadPlayer=["PlayerStats",_ae,0]call EPOCH_server_hiveGETBIT;_al=(_deadPlayer ||(_ak select 3==1)||(_at select 2==1)||(_at select 3==1)||(_as select 12 >=180));if(_al || _ap !=_ac ||(count _ao)< 3 || typeName _ao !="ARRAY")then{_an=random 360;_ao=getMarkerPos "respawn_west";_ao set[2,0];if(_al)then{_as=EPOCH_defaultVars_SEPXVar;_ar=true;};};_au=grpNull;{if((_x getVariable["PUID","0"])==_ae)then{deleteVehicle _x;};}forEach allUnits;if(_aq !="")then{{if((_x getVariable["GROUP",""])==_aq)exitWith{_au=group _x;};}forEach playableUnits;};if(isNull _au)then{_au=createGroup west;};_av=_au createUnit[_ai,_ao,[],0,"CAN_COLLIDE"];if !(isNull _av)then{removeGoggles _av;_av allowDamage false;{_av disableAI _x;}forEach["FSM","MOVE","AUTOTARGET","TARGET"];_av setDir _an;_av setPosATL _ao;_aw="";if(!_al)then{_av setBleedingRemaining(_ak select 0);_av setOxygenRemaining(_ak select 2);_av setDamage(_ak select 3);_ax=_ag select 2;_ay=_ax select 0;_az=_ax select 1;_aj=_ax select 2;_aab=_ax select 3;_aac=_ax select 4;if(_aac !="")then{_av addUniform _aac;};if(_aab !="")then{_av addBackpack _aab;};if(_ay !="")then{_av addGoggles _ay;};if(_az !="")then{_av addHeadgear _az;};if(_aj !="")then{_av addVest _aj;};_aad=_ag select 5;if(count _aad >=2)then{_aae=_aad select 2;{_aaf=_x select 0;_aag=getNumber(configfile >> "cfgweapons" >> _aaf >> "type");_aah=[];for "_a" from 1 to 3 do{_aai=_x select _a;if(_aai !="")then{_aah pushBack _aai;};};_aaj=(count _x)==5;if(_aaf in _aae)then{_aae=_aae-[_aaf];if(_aaj)then{_av addMagazine(_x select 4);};if(_aaf !="")then{_av addWeapon _aaf;};switch _aag do{case 1:{removeAllPrimaryWeaponItems _av;{_av addPrimaryWeaponItem _x}forEach _aah;};case 2:{removeAllHandgunItems _av;{_av addHandgunItem _x}forEach _aah;};case 4:{{_av addSecondaryWeaponItem _x}forEach _aah;};};}else{{_av addItem _x;}forEach _aah;if(_aaj)then{_av addMagazine(_x select 4);};};}forEach(_aad select 1);_aw=_aad select 0;};{if(_x in["Binocular","Rangefinder"])then{_av addWeapon _x;}else{_av linkItem _x;};}forEach(_ag select 6);{_aak=_forEachIndex;_aal=_x select 1;{for "_i" from 1 to(_aal select _forEachIndex)do{switch _aak do{case 0:{_av addItemToUniform _x};case 1:{_av addItemToVest _x};case 2:{_av addItemToBackpack _x};};};}forEach(_x select 0);}forEach(_ag select 8);{_aak=_forEachIndex;_aal=_x select 1;{for "_i" from 1 to(_aal select _forEachIndex)do{switch _aak do{case 0:{_av addItemToUniform _x};case 1:{_av addItemToVest _x};case 2:{_av addItemToBackpack _x};};};}forEach(_x select 0);}forEach(_ag select 9);{_av addMagazine _x;}forEach(_ag select 7);};if(isNull _ab)then{deleteVehicle _av;diag_log "DEBUG: _ab object was null reject connection";}else{_aa=false;if(_aq !="")then{_af=["Group",_aq]call EPOCH_server_hiveGET;_found=false;if((_af select 0)==1 && typeName(_af select 1)=="ARRAY" && !((_af select 1)isEqualTo[]))then{_contentArray=_af select 1;_found=_aq==_ae;if(!_found)then{{if(_x select 0==_ae)exitWith{_found=true;};}forEach(_contentArray select 4);};if(!_found)then{{if(_x select 0==_ae)exitWith{_found=true;};}forEach(_contentArray select 3);};if(_found)then{Epoch_my_Group=_contentArray;_ad publicVariableClient "Epoch_my_Group";_av setVariable["GROUP",_aq];};};if(!_found)then{_aq="";};};_ab setPosATL _ao;_av setVariable["SETUP",true];_av setVariable["PUID",_ae];if !(_as isEqualTo[])then{_av setVariable["VARS",_as];};if(!_ar)then{_av setVariable["REVIVE",_ar]};[_ad,_ae,[_av,_as,_aw,count(magazines _av),_aq,_ar,_av call EPOCH_server_setPToken]]call EPOCH_server_pushPlayer;};}else{diag_log format["LOGIN FAILED UNIT NULL: %1 [%2|%3]",_ab,_au,count allgroups];};};};};if(_aa)then{diag_log format["DEBUG PLAYER NOT SETUP OR INVAILD: %1",_ab];BAD_HIVE=true;_ad publicVariableClient "BAD_HIVE";};true
