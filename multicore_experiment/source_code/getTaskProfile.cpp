#include "getTaskProfile.h"
map<string, map<string,double> > GetTaskProfile::get_idle_voltage_time(){
  return idle_voltage_time;
}
vector<voltage_list *> GetTaskProfile::get_voltage_list(){
  return voltages;
}
vector<string > GetTaskProfile::get_time_list(){
  return time;
}
int GetTaskProfile::convertTime(string time){
  if(time == "0m"){
    return 0;
  }else if(time == "1m"){
    return 2628000;
  }else if(time == "2m"){
    return 5256000;
  }else if(time == "3m"){
    return 7884000;
  }else if(time == "4m"){
    return 10512000;
  }else if(time == "5m"){
    return 13140000;
  }else if(time == "6m"){
    return 15768000;
  }else if(time == "7m"){
    return 18396000;
  }else if(time == "8m"){
    return 21024000;
  }else if(time == "9m"){
    return 23652000;
  }else if(time == "10m"){
    return 26280000;
  }else if(time == "11m"){
    return 28908000;
  }else if(time == "1y"){
    return 31536000;
  }else if(time == "2y"){
    return 63072000;
  }else if(time == "3y"){
    return 94608000;
  }else if(time == "4y"){
    return 126144000;
  }else if(time == "5y"){
    return 157680000;
  }else if(time == "6y"){
    return 189216000;
  }else if(time == "7y"){
    return 220752000;
  }else if(time == "8y"){
    return 252288000;
  }else if(time == "9y"){
    return 283824000;
  }else if(time == "10y"){
    return 315360000;
  }else if(time == "11y"){
    return 346896000;
  }else if(time == "12y"){
    return 378432000;
  }else if(time == "13y"){
    return 409968000;
  }else if(time == "14y"){
    return 441504000;
  }else if(time == "15y"){
    return 473040000;
  }else if(time == "16y"){
    return 504576000;
  }else if(time == "17y"){
    return 536112000;
  }else if(time == "18y"){
    return 567648000;
  }else if(time == "19y"){
    return 599184000;
  }else if(time == "20y"){
    return 630720000;
  }
  else{
    return 0;
  }          
}
void GetTaskProfile::startGet(char * benchmark_name, char *Fre, char *Num_Iv){
  cout.setf(ios::fixed, ios::floatfield);
  cout.precision(20);
  string Frequency(Fre);
  int Frequency_int = atoi(Frequency.c_str() );
  Frequency = "_" + Frequency + "_";
  string path = "../hspice_experiment/hspice_result/";
  string benchmark(benchmark_name );
  path = path + benchmark + "/";
  string folder;
  string name;
  string full;

  // 2019/12/25 add write benchmark_profile
  string write_benchmark_profile = "benchmark_profile/" + benchmark + "_profile_"+ "10" +".csv";
  fstream OFS;
  OFS.open(write_benchmark_profile.c_str(), ios::out);
  //OFS.open(write_benchmark_profile);

  for(unsigned p = 0 ; p < List.size() ; p++){
    for(int i = 1 ; i < (int)List[p].size() - 1; ++i){
      stringstream ss;
      int mod_number = i;
      if(mod_number > 40){
        mod_number = mod_number % 40;
      }
      else if(mod_number > 30){
        mod_number = mod_number % 30;
      }
      else if(mod_number > 20){
        mod_number = mod_number % 20;
      }
      else if(mod_number > 10){
        mod_number = mod_number % 10;
      }
      if(mod_number == 0 ){
        mod_number = 1;
      }
      ss << (mod_number - 1);
      string index_str = ss.str();
      //cout <<"\ntask id,"<< List[p][i]->id << endl;
      //cout <<"voltage, age, delay(ns), power(n watts) " << endl;
      for(unsigned int j = 0 ; j < voltages.size() ; ++j){
        for(unsigned int k = 0 ; k < time.size() ; ++k){
          //cout << voltages[j]->voltage_str <<",";
          folder = index_str + "_" + voltages[j]->voltage_str + Frequency + time[k];
          //int second = convertTime(time[k]);
          name = folder + ".mt0";
          full = path + index_str + "/" + folder +"/"+ name;
          //cout << full << endl; 
          ReadMT readmt(full.c_str(), input_port, output_port);
          double delay = readmt.computeDelay(Frequency_int, (atoi(Num_Iv) + 1) );
          if(List[p][i]->min_exec_time > delay){
            List[p][i]->min_exec_time = delay;
          }        
          double avg_power = readmt.getValue("avg_power");
          Info *info = new Info();
          info->delay = delay;
          //cout << time[k] << ","; 
          //cout << delay * 1000000000 << ","; 
          //cout << "delay: " << delay  << endl; 
          //cout << second <<"," << delay * 1000000000 << endl;
          info->avg_power = avg_power;
          //cout << avg_power * 1000000000 << endl;
          //cout << "avg_power: " << avg_power  << endl; 
          map<string, map<string, Info*> >::iterator it;
          it = List[p][i]->map_voltage_time.find(voltages[j]->voltage_str);
          if(it == List[p][i]->map_voltage_time.end() ){
            map<string, Info*> map_time;
            map_time.insert(pair<string, Info*>(time[k], info));
            List[p][i]->map_voltage_time.insert(pair<string, map<string, Info*> >(voltages[j]->voltage_str, map_time) );         
          }
          else{//find
            it->second.insert(pair<string, Info*>(time[k], info));
          }
        }
      } 
    }
    for(int i = 1 ; i < (int)List[p].size() - 1; ++i){
      for(unsigned int j = 0 ; j < voltages.size() ; ++j){
        map<string, map<string, Info*> >::iterator it;
        it = List[p][i]->map_voltage_time.find(voltages[j]->voltage_str);
        double next_delay = 0.0, next_power = 0.0;
        double last_delay = 0.0, last_power = 0.0;
        double delay = 0.0, power = 0.0;
        for(unsigned int k = 0 ; k < time.size()-1 ; ++k){
          map<string, Info* >::iterator itt;
          map<string, Info* >::iterator next_itt;
          itt = it->second.find(time[k]);
          delay = itt->second->delay;
          power = itt->second->avg_power;
          next_itt = it->second.find(time[k+1]);
          next_delay = next_itt->second->delay;
          next_power = next_itt->second->avg_power;
          if(k > 0){
            if(delay > next_delay){
              itt->second->delay = (last_delay + next_delay)/2;
              itt->second->avg_power = (last_power + next_power)/2;
              delay = itt->second->delay;
              power = itt->second->avg_power;
            }
          }
          last_delay = delay;    
          last_power = power;     
        }
      } 
    }
    
    for(int i = 1 ; i < (int)List[p].size() - 1; ++i){
      cout <<"\n#task id,"<< List[p][i]->id << endl;
      cout <<"#voltage, age, delay(ns), power(n watts) " << endl;
      OFS <<"\n#task id,"<< List[p][i]->id << endl;
      OFS <<"#voltage, age, delay(ns), power(n watts) " << endl;
      for(unsigned int j = 0 ; j < voltages.size() ; ++j){
        map<string, map<string, Info*> >::iterator it;
        it = List[p][i]->map_voltage_time.find(voltages[j]->voltage_str);
        double delay = 0.0, power = 0.0;
        for(unsigned int k = 0 ; k < time.size(); ++k){
          map<string, Info* >::iterator itt;
          itt = it->second.find(time[k]);
          delay = itt->second->delay;
          power = itt->second->avg_power;
          cout << voltages[j]->voltage_str <<","<<time[k] << "," << convertTime(time[k]) <<"," << delay  << "," << power << endl;       
          OFS << voltages[j]->voltage_str <<","<<time[k] << "," << convertTime(time[k]) <<"," << delay  << "," << power << endl;       
        }
        cout << endl;
        OFS << endl;
      } 
    }    
  }
  
  string index_str = "10";
  cout << "#idle task" << endl;
  cout <<"#voltage, age, power(n watts) " << endl;
  OFS << "#idle task" << endl;
  OFS <<"#voltage, age, power(n watts) " << endl;
  for(unsigned int j = 0 ; j < voltages.size() ; ++j){
   for(unsigned int k = 0 ; k < time.size() ; ++k){
     folder = index_str + "_" + voltages[j]->voltage_str + Frequency + time[k];
     name = folder + ".mt0";
     full = path + index_str + "/" + folder +"/"+ name;
     //cout << full << endl; 
     ReadMT readmt(full.c_str(), input_port, output_port);
     double idle_power = readmt.getValue("idle_power");
     //cout << "idle_power: "<< idle_power * 1000000000 << " n watts" << endl;
     map<string, map<string, double> >::iterator it;
     it = idle_voltage_time.find(voltages[j]->voltage_str);
     if(it == idle_voltage_time.end() ){
       map<string, double> map_idle;
       map_idle.insert(pair<string, double>(time[k], idle_power));
       idle_voltage_time.insert(pair<string, map<string, double> >(voltages[j]->voltage_str, map_idle) );         
     }
     else{//find
       it->second.insert(pair<string, double>(time[k], idle_power));
     }
     cout << voltages[j]->voltage_str <<","<<time[k] <<"," << convertTime(time[k]) << "," << idle_power<< endl;
     OFS << voltages[j]->voltage_str <<","<<time[k] <<"," << convertTime(time[k]) << "," << idle_power<< endl;
   }
   cout << endl;
   OFS << endl;
  }
}
//../my_experiment/hspice_result/1/1_14_100_10y/1_14_100_10y.mt0
GetTaskProfile::GetTaskProfile(vector<vector<Task *> > List, vector<string> &input_port, vector<string> &output_port, char * benchmark_name, char *Frequency, char *Num_Iv){
  this->List = List;
  this->input_port = input_port;
  this->output_port = output_port;
  //for(int i = 8 ; i < 13 ; ++i){
  //for(int i = 8 ; i < 9 ; ++i){
  for(int i = 12 ; i < 13 ; ++i){
    voltage_list *v = new voltage_list();
    stringstream ss;
    ss << i;
    string str = ss.str();
    if(i < 10){
      v->voltage_str = "0" + str;
      //voltage_str.push_back("0" + str);
    }
    else{
      v->voltage_str = str;
      //voltage_str.push_back(str);
    }
    v->voltage = ((double)i) / 10.0;
    //voltage.push_back( ((double)i) / 10.0 );
    voltages.push_back(v);
  }
  
  for(int i = 0 ; i < 12 ; ++i){
    stringstream ss;
    ss << i;
    string str = ss.str();    
    time.push_back(str + "m");
  }
  for(int i = 1 ; i < 21 ; ++i){
    stringstream ss;
    ss << i;
    string str = ss.str();    
    time.push_back(str + "y");
  }
  startGet(benchmark_name, Frequency, Num_Iv);
  //computeDeadlineTime();
}
