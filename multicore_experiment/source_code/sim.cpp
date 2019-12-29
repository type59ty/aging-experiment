#include "sim.h"
#define NS 1000000000
#define NS_SQ NS*NS
#define END_TASK 11
#define START_TASK 3
#define START_TASK2 10
bool cmp(const TaskInfo &a, const TaskInfo &b){
  return a.cost < b.cost;
}
bool voltage_cmp(const TaskInfo &a, const TaskInfo &b){
  return a.v.voltage > b.v.voltage;
  //return a->operate_time < b->operate_time;
}  
bool reScheduling_cmp(const Task *a, const Task *b){
  if(a->ready_time < b->ready_time){
    return true;
  }
  else{
    if(a->last_start_time < b->last_start_time){
      return true;
    }
    return false;
  }
}
bool ready_cmp(const Task *a, const Task *b){
  return a->ready_time < b->ready_time;
}
bool deadline_cmp(const Task *a, const Task *b){
  return a->deadline_time < b->deadline_time;
}
bool last_start_time_cmp(const Task *a, const Task *b){
  return a->last_start_time < b->last_start_time;
}
bool slack_cmp(const TaskInfo &a, const TaskInfo &b){
  return a.slack < b.slack;
}
bool index_cmp(const Processor *a, const Processor *b){
  return a->index < b->index;
}
bool operate_time_cmp(const Processor *a, const Processor *b){
  return a->vth < b->vth;
}
bool spare_core_cmp(const Processor *a, const Processor *b){
  if(a->isProtect == true){
    return true;
  }
  else{
    return false;
  }
}
void Sim::print_debugList(vector<DebugInfo> &debugList){
  for(unsigned int i = 0 ; i < debugList.size() ; ++i){
    wfile << "\nTask " << debugList[i].id << " schedule in core " << debugList[i].proc_index << " "<< debugList[i].aging_time << endl;
    wfile << " ready_time is: " << debugList[i].ready_time<< " ns"<< endl;
    wfile << " last_start_time is: " << debugList[i].last_start_time<< " ns"<< endl;
    wfile << " Voltage is: " << debugList[i].voltage <<" V"<< endl;
    wfile << " delay is: " << debugList[i].delay << " ns" << endl;
    wfile << " dynamic_power is: " << debugList[i].dynamic_power << " n watts" << endl;
    wfile << " Exec time is: " << debugList[i].exec_time << " ns" << endl;
    wfile << " deadline time is: " << debugList[i].deadline_time * NS<< " ns"<< endl;
    wfile << " Finish time is: " << debugList[i].finish_time<< " ns"<< endl;
    wfile << " Task Energy is: " << debugList[i].Energy_t << " n watts"<< endl;           
  }   
}
void Sim::print(){
  wfile << "=============================================="  << endl;
  wfile << "Simulator time: "<< aging_time <<", "<< this->operate_time * NS <<endl;
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    wfile << "============================"  << endl;  
    wfile << "core " << i << endl;
    wfile << " Protected: " << Processor_List[i]->isProtect << endl;
    wfile << " operate time is: " << Processor_List[i]->operate_time * NS << " ns" << endl;
    total_operate_time += Processor_List[i]->operate_time * NS;
    wfile << " aging time is: " << Processor_List[i]->aging_time <<", "<< Processor_List[i]->vth<<endl;
  }
  wfile <<  " \ntotal operate time is: " << total_operate_time << " ns"<< endl;
  wfile <<  " total energy is: " << total_energy << " n watts"<< endl;
  w_policy_file << aging_time <<", "<< this->operate_time * NS << ", "<< total_energy << endl;
}

void Sim::ratioRelease(Task *task, Task *pre_task, double ratio){
  pre_task->ratio = ratio;
  pre_task->isTight = true;
  double pre_exec_time = pre_task->min_exec_time * (double)pre_task->cycle; 
  pre_task->deadline_time = pre_task->ready_time + (pre_exec_time * pre_task->ratio);
  pre_task->last_start_time = pre_task->deadline_time - pre_exec_time;
  for(unsigned int i = 0 ;i < pre_task->next.size() ; ++i){
    Task * next = pre_task->next[i];
    next->ready_time = pre_task->deadline_time;
    double next_exec_time = next->min_exec_time * (double)next->cycle;
    next->ready_time_backup = next->ready_time;
    next->min_finish_time = next->ready_time + next_exec_time;
    next->ratio = (next->deadline_time - next->ready_time) / next_exec_time;
  }  
}
unsigned int Sim::checkCriticalOverlap(){
  critical_List.clear();
  overlap_task_map.clear();
  overlap_task_list.clear();
  critical_couple_list.clear();
  double min_ratio = 100.0;
  //find the minimum ratio
  for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
    if(sorted_List[i]->id != 0 && sorted_List[i]->id != END_TASK){
      if(sorted_List[i]->ratio < min_ratio){
        min_ratio = sorted_List[i]->ratio;
      }
    }
  }
  //cout << "min_ratio: "<<min_ratio << endl;
  for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
    if(sorted_List[i]->ratio == min_ratio || sorted_List[i]->isTight == true){
      critical_List.push_back(sorted_List[i]);
      sorted_List[i]->isCritical = true;
    }
    else{
      sorted_List[i]->isCritical = false;
    }
  }
  //find the maxmium overlap number at same time
  vector<Task * > arrl;
  vector<Task * > exit;
  for(unsigned int i = 0 ; i < critical_List.size() ; ++i){
    arrl.push_back(critical_List[i]);
    exit.push_back(critical_List[i]);
  }
  sort(arrl.begin(), arrl.end(), ready_cmp);
  sort(exit.begin(), exit.end(), deadline_cmp);
  unsigned int num_overlap = 1, max_overlap = 1;
  unsigned int next_index = 1, index = 0;
  double time = arrl[0]->ready_time;
  vector<Task * > Tmp_overlap_list;
  Tmp_overlap_list.push_back(arrl[0]);
  while(next_index < arrl.size() && index < arrl.size() ){
    if(arrl[next_index]->ready_time < exit[index]->deadline_time){
      Tmp_overlap_list.push_back(arrl[next_index]);
      num_overlap++;
      if(num_overlap > max_overlap){
        max_overlap = num_overlap;
        time = arrl[next_index]->ready_time;
      }
      next_index++;
    }
    else{
      unsigned int erase_index = 0;
      for(; erase_index < Tmp_overlap_list.size() ; ++erase_index){
        if(Tmp_overlap_list[erase_index]->id == exit[index]->id ){
          break;
        }
      }
      Tmp_overlap_list.erase(Tmp_overlap_list.begin() + erase_index);
      num_overlap--;
      index++;
    }
  }
  /*cout << "Max overlap = " << max_overlap << endl;*/
  //check all the overlap couple task
  for(unsigned int i = 0 ; i < critical_List.size() ; ++i){
    for(unsigned int j = i + 1 ; j < critical_List.size() ; ++j){
      vector<Task * > couple;
      couple.push_back(critical_List[i]);
      couple.push_back(critical_List[j]);
      if( (critical_List[i]->ready_time < critical_List[j]->deadline_time ) && (critical_List[i]->deadline_time > critical_List[j]->ready_time ) ){
        map<int, vector<Task *> >::iterator it = overlap_task_map.find(critical_List[i]->id);
        //cout << critical_List[i]->id << ", " << critical_List[j]->id << endl;
        if(it == overlap_task_map.end()){
          vector<Task *> tmp;
          tmp.push_back(critical_List[j]);
          overlap_task_map.insert(pair<int, vector<Task *> >(critical_List[i]->id, tmp));
          if(!critical_List[i]->isRelease){
            overlap_task_list.push_back(critical_List[i]);
          }
        }
        else{
          it->second.push_back(critical_List[j]);
        }
        it = overlap_task_map.find(critical_List[j]->id);
        if(it == overlap_task_map.end()){
          vector<Task *> tmp;
          tmp.push_back(critical_List[i]);
          overlap_task_map.insert(pair<int, vector<Task *> >(critical_List[j]->id, tmp));
          if(!critical_List[j]->isRelease){
            overlap_task_list.push_back(critical_List[j]);
          }
        }
        else{
          it->second.push_back(critical_List[i]);
        }
        critical_couple_list.push_back(couple);
      }
    }
  }
  sort(overlap_task_list.begin(), overlap_task_list.end(), reScheduling_cmp);
  return max_overlap;   
}

void Sim::reScheduling(){
  overlap_counter = checkCriticalOverlap();
  while( !overlap_task_list.empty() ){
    Task *task = overlap_task_list.front();
    task->isRelease = true;
    if(task->ready_time == 0){//top
      overlap_task_list.erase(overlap_task_list.begin() );
      continue;
    }
    map<int, vector<Task *> >::iterator it = overlap_task_map.find(task->id);//find overlap task of this task 
    unsigned int counter = 0;
    Task * overlap_task = NULL;    
    for(unsigned int i = 0 ; i < it->second.size() ; i++){
      overlap_task = it->second[i];
      if(overlap_task->ready_time == 0.0 ){
        counter++;
      }
    }
    if(counter == it->second.size() ){//all overlap tasks of this task are at top
    //if(counter == it->second.size() || (overlap_task->pre.front()->id == task->pre.front()->id) ){//all overlap tasks of this task are at top
      overlap_task_list.erase(overlap_task_list.begin() );
      continue;      
    }
    //Task *pre_task = task->pre.front();
    Task *pre_task = NULL;
    double Max_deadline = 0.0;
    for(unsigned int i = 0 ; i < task->pre.size() ; ++i){
      if(task->pre[i]->deadline_time > Max_deadline){
        Max_deadline = task->pre[i]->deadline_time;
        pre_task = task->pre[i];
      }
    }
    //if the pre task is critical 
    //if(pre_task->isCritical || pre_task->id == START_TASK || pre_task->id == START_TASK2){
    if(pre_task->isCritical){
      overlap_task_list.erase(overlap_task_list.begin() );
      continue; 
    }
    vector<Task > backup_Task_List;
    double pre_ratio = pre_task->ratio;
    while(1){
      pre_ratio = pre_ratio - 0.1;
      backup_Task_List.clear();
      for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
        Task tmp_task;
        tmp_task.isCritical        = sorted_List[i]->isCritical;
        tmp_task.isRelease         = sorted_List[i]->isRelease;
        tmp_task.isTight           = sorted_List[i]->isTight;
        tmp_task.ratio             = sorted_List[i]->ratio;
        tmp_task.deadline_time     = sorted_List[i]->deadline_time;
        tmp_task.last_start_time   = sorted_List[i]->last_start_time;
        tmp_task.ready_time        = sorted_List[i]->ready_time;
        tmp_task.ready_time_backup = sorted_List[i]->ready_time_backup;
        tmp_task.min_finish_time   = sorted_List[i]->min_finish_time;
        backup_Task_List.push_back(tmp_task);
      }
      ratioRelease(task, pre_task, pre_ratio);
      double min_task_ratio = task->ratio;
      for(unsigned int i = 0 ; i < pre_task->next.size() ; ++i){
        if(pre_task->next[i]->ratio < min_task_ratio){
          min_task_ratio = pre_task->next[i]->ratio;
        }
      }
      //cout << min_task_ratio << endl;
      if(min_task_ratio <= pre_task->ratio){
        for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
          sorted_List[i]->isCritical        = backup_Task_List[i].isCritical        ; 
          sorted_List[i]->isRelease         = backup_Task_List[i].isRelease         ;
          sorted_List[i]->isTight           = backup_Task_List[i].isTight           ;          
          sorted_List[i]->ratio             = backup_Task_List[i].ratio             ; 
          sorted_List[i]->deadline_time     = backup_Task_List[i].deadline_time     ; 
          sorted_List[i]->last_start_time   = backup_Task_List[i].last_start_time   ; 
          sorted_List[i]->ready_time        = backup_Task_List[i].ready_time        ; 
          sorted_List[i]->ready_time_backup = backup_Task_List[i].ready_time_backup ; 
          sorted_List[i]->min_finish_time   = backup_Task_List[i].min_finish_time   ; 
        }        
        continue;
      }
      else{
        break;
      }
    }
    //ratioRelease(task, pre_task, task->ratio); 
    unsigned int this_time_overlap = checkCriticalOverlap();
    if(this_time_overlap >= overlap_counter ){//bad
      for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
        sorted_List[i]->isCritical        = backup_Task_List[i].isCritical        ;         
        sorted_List[i]->ratio             = backup_Task_List[i].ratio             ; 
        sorted_List[i]->deadline_time     = backup_Task_List[i].deadline_time     ; 
        sorted_List[i]->last_start_time   = backup_Task_List[i].last_start_time   ; 
        sorted_List[i]->ready_time        = backup_Task_List[i].ready_time        ; 
        sorted_List[i]->ready_time_backup = backup_Task_List[i].ready_time_backup ; 
        sorted_List[i]->min_finish_time   = backup_Task_List[i].min_finish_time   ; 
      }
      checkCriticalOverlap();
    }
    else{
      task->isCritical = false;
      overlap_counter = this_time_overlap;
    }

  }
  wfile << endl << "reScheduling: "<<endl;
  for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
    wfile << "id: "<< sorted_List[i]->id << endl;
    wfile << " ready time "<< sorted_List[i]->ready_time *NS << " ns deadline " << sorted_List[i]->deadline_time * NS <<" ns"<< endl;
    wfile << " finish time "<< sorted_List[i]->min_finish_time *NS << " ns " << endl;
    wfile << " Critical ratio "<< sorted_List[i]->ratio << endl;
    wfile << " last_start_time "<< sorted_List[i]->last_start_time *NS << " ns deadline " << sorted_List[i]->deadline_time * NS <<" ns"<< endl;   
  }
}
void Sim::setDeadline(vector<unsigned int> &critical_task_list){
  vector<Task *>::iterator it = sorted_List.begin();
  double min_ratio = 100.0;
  while(it != sorted_List.end()){
    Task *task = *it;
    double exec_time = 0.0, finish_time = 0.0;
    if(task->id != 0 && task->id != END_TASK ){
      for(unsigned int i = 0 ; i < critical_task_list.size() ; ++i){
        if( (int)critical_task_list[i] == task->id){
          exec_time = task->min_exec_time * (double)task->cycle * critical_ratio;
          task->ratio = critical_ratio;
          task->multithread = true;
          break;
        }
        else{
          exec_time = task->min_exec_time * (double)task->cycle * nonCritical_ratio;
          task->ratio = nonCritical_ratio;
          task->multithread = false;
        }
      }
      finish_time  = task->ready_time + exec_time;
      task->min_finish_time = task->ready_time + (task->min_exec_time * (double)task->cycle);
      task->deadline_time = task->ready_time + exec_time;
      task->last_start_time = task->deadline_time - (task->min_exec_time * (double)task->cycle);
      //task->ratio = exec_time/(task->min_exec_time * (double)task->cycle);
      if(task->ratio < min_ratio){
        min_ratio = task->ratio;
      }
    }
    for(unsigned int i = 0 ; i < task->next.size() ; ++i){
      Task *next = task->next[i];
      if(finish_time > next->ready_time){
        next->ready_time = finish_time;
        next->ready_time_backup = next->ready_time;
      }
    }
    it++;        
  }
  for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
    wfile << "id: "<< sorted_List[i]->id << endl;
    wfile << " ready time "<< sorted_List[i]->ready_time *NS << " ns deadline " << sorted_List[i]->deadline_time * NS <<" ns"<< endl;
    wfile << " finish time "<< sorted_List[i]->min_finish_time *NS << " ns " << endl;
    wfile << " Critical ratio "<< sorted_List[i]->ratio << endl;
    wfile << " last_start_time "<< sorted_List[i]->last_start_time *NS << " ns deadline " << sorted_List[i]->deadline_time * NS <<" ns"<< endl;
  }
}
void Sim::compute_delta_vth(Processor * proc, string voltage, double exec_time){
  double delta_vth = proc->delta_vth;
  double equal_time = 0.0, alpha = 0.0, beta = 0.1667;
  if(voltage == "08"){
    alpha = 0.0046;
  }else if(voltage == "09"){
    alpha = 0.0048;
  }else if(voltage == "10"){
    alpha = 0.0051;
  }else if(voltage == "11"){
    alpha = 0.0053;
  }else{//voltage = 1.2v
    alpha = 0.0056;
  }
  equal_time = pow(delta_vth/alpha, 1.0/beta);
  proc->delta_vth = alpha * pow( (equal_time + exec_time), beta);
  proc->vth = proc->ori_vth + proc->delta_vth;
  /*if( (this->operate_time * NS) >= vth_counter){
    vth_file <<vth_counter << ",";
    for(unsigned int i = 0 ; i < Processor_List.size(); ++i){
      vth_file << Processor_List[i]->vth << ",";
    }
    vth_file << endl;
    vth_counter += 100000.0;
  }*/
}
double Sim::tmp_compute_delta_vth(Processor * proc, string voltage, double exec_time){
  double delta_vth = proc->delta_vth;
  double equal_time = 0.0, alpha = 0.0, beta = 0.1667;
  if(voltage == "08"){
    alpha = 0.0046;
  }else if(voltage == "09"){
    alpha = 0.0048;
  }else if(voltage == "10"){
    alpha = 0.0051;
  }else if(voltage == "11"){
    alpha = 0.0053;
  }else{//voltage = 1.2v
    alpha = 0.0056;
  }
  equal_time = pow(delta_vth/alpha, 1.0/beta);
  proc->delta_vth = alpha * pow( (equal_time + exec_time), beta);
  proc->vth = proc->ori_vth + proc->delta_vth;
  return proc->vth; 
}
void Sim::parse_vth(){
  string full = "../vths.log";
  ifstream file(full.c_str(), ios::in);
  string line, time, value;
  while(getline(file, line, '\n')){
    time = Parseline(line); // time
    value = Parseline(line); // value
    //cout << "time " << time << ", value " << value << endl;
    vths.insert(pair<string, double>( time , atof( value.c_str() ) ));
  }
}
bool Sim::update(Processor *proc){
  string aging_time;
  if(proc->aging_time == "0m"){
    aging_time = "1m";
  }else if(proc->aging_time =="1m"){
    aging_time = "2m";
  }else if(proc->aging_time =="2m"){
    aging_time = "3m";
  }else if(proc->aging_time =="3m"){
    aging_time = "4m";
  }else if(proc->aging_time =="4m"){
    aging_time = "5m";
  }else if(proc->aging_time =="5m"){
    aging_time = "6m";
  }else if(proc->aging_time =="6m"){
    aging_time = "7m";
  }else if(proc->aging_time =="7m"){
    aging_time = "8m";
  }else if(proc->aging_time =="8m"){
    aging_time = "9m";
  }else if(proc->aging_time =="9m"){
    aging_time = "10m";
  }else if(proc->aging_time =="10m"){
    aging_time = "11m";
  }else if(proc->aging_time =="11m"){
    aging_time = "1y";
  }else if(proc->aging_time =="1y"){
    aging_time = "2y";
  }else if(proc->aging_time =="2y"){
    aging_time = "3y";
  }else if(proc->aging_time =="3y"){
    aging_time = "4y";
  }else if(proc->aging_time =="4y"){
    aging_time = "5y";
  }else if(proc->aging_time =="5y"){
    aging_time = "6y";
  }else if(proc->aging_time =="6y"){
    aging_time = "7y";
  }else if(proc->aging_time =="7y"){
    aging_time = "8y";
  }else if(proc->aging_time =="8y"){
    aging_time = "9y";
  }else if(proc->aging_time =="9y"){
    aging_time = "10y";
  }else if(proc->aging_time =="10y"){
    aging_time = "11y";
  }else if(proc->aging_time =="11y"){
    aging_time = "12y";
  }else if(proc->aging_time =="12y"){
    aging_time = "13y";
  }else if(proc->aging_time =="13y"){
    aging_time = "14y";
  }else if(proc->aging_time =="14y"){
    aging_time = "15y";
  }else if(proc->aging_time =="15y"){
    aging_time = "16y";
  }else if(proc->aging_time =="16y"){
    aging_time = "17y";
  }else if(proc->aging_time =="17y"){
    aging_time = "18y";
  }else if(proc->aging_time =="18y"){
    aging_time = "19y";
  }else if(proc->aging_time =="19y"){
    aging_time = "20y";
  }else if(proc->aging_time =="20y"){
    aging_time = "21y";  
  }else if(proc->aging_time =="21y"){
    aging_time = "22y";
  }  
  map<string, double>::iterator it = vths.find(aging_time);
  if(it == vths.end()){
	return 0;
    /*print();
    throw runtime_error("can't find next vth");*/
  }
  double next_vth = it->second;
  if(proc->vth >= next_vth){
    set_process_vth(proc, aging_time);
  }
  return 1;
}
void Sim::reset(){
  isOpen = false;
  overlap_counter = 1;
  this->aging_time = ""; //reset simulator time (month, year) to ""
  readyQuere.clear(); //reset ready Queue
  simulation_time = 0.0; //reset simulator time (year)
  total_operate_time = 0.0; //reset total core's operate time (s)
  total_energy = 0.0; //reset simulator energy
  operate_time = 0.0; //reset simulator operate time
  period = 0.0;
  //reset each core state to initial
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    Processor_List[i]->operate_time = 0.0;
    Processor_List[i]->ori_vth = 0.45;
    Processor_List[i]->vth = 0.45;
    Processor_List[i]->delta_vth = 0.0;
    Processor_List[i]->aging_time = "0m";
    Processor_List[i]->available_time = 0.0;
    Processor_List[i]->idle_time = 0.0;
    Processor_List[i]->total_power = 0.0;
    Processor_List[i]->isProtect = false;
    if(Processor_List.size() > 4 && i == 0){
      Processor_List[i]->isProtect = true;
    }
    Processor_List[i]->index = i;
  }
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    update(Processor_List[i]);
  }
  //=======將task graph給initial
  for(unsigned int k = 0 ; k < sorted_List.size() ; ++k){
    sorted_List[k]->ready_time = 0.0;
    sorted_List[k]->ready_time_backup = 0.0;
    sorted_List[k]->isRelease = false;      
    sorted_List[k]->isCritical = false; 
    sorted_List[k]->isTight = false; 
  }
  vth_counter = 0;  
}

Sim::Sim(vector<Task *> List, int num_processor, map<string, map<string,double> >& idle_voltage_time, vector<voltage_list *>& voltages,
         double critical_ratio, double nonCritical_ratio, vector<vector<unsigned int> > &critical_list){
  wfile.setf(ios::fixed, ios::floatfield);
  wfile.precision(10);
  w_policy_file.setf(ios::fixed, ios::floatfield);
  w_policy_file.precision(10);
  vth_file.setf(ios::fixed, ios::floatfield);
  vth_file.precision(10);
  srand( (unsigned)time(NULL) );;// set random srand
  //set crtitcal ratio and non critical ratio
  this->critical_ratio = critical_ratio;
  this->nonCritical_ratio = nonCritical_ratio;
  this->critical_list = critical_list; //set critical tasks list
  //set task graph
  this->List = List;
  //set voltage and idle power map
  this->idle_voltage_time = idle_voltage_time;
  //set voltage list
  this->voltages = voltages;
  //set each core state

  //set month time
  double month = 1.0/12.0;
  for(unsigned int i = 0 ; i < 11 ; ++i){
    months.push_back(month);
    //cout << month <<endl;
    month = month + (1.0/13.0);
  }
  //parse vth value file, which is in my_backup directory
  parse_vth(); 
  for(int i = 0 ; i < num_processor ; ++i){
    Processor *proc = new Processor();
    Processor_List.push_back(proc); 
  }
  vth_counter = 0.0;
  isOpen = false;
  reset();//reset some parameter
}

string Sim::Parseline(string &line){
  std::string token("");
  std::string::size_type  index = 0;
  while(line.size() > 0){
    if((line[index] >= '0'  && line[index] <= '9')  || 
       (line[index] >= 'A'  && line[index] <= 'Z')  || 
       (line[index] >= 'a'  && line[index] <= 'z')  ||
       (line[index] == '.') ){
      token += line[index];
      line.erase(line.begin());      
    }
    else if(line[index] == '\0' || token.size() > 0)
      return token;
    else
      line.erase(line.begin());
  }
  return token;    
}
void Sim::set_process_vth(Processor *proc, string time){
  map<string, double>::iterator it = vths.find(time);
  if(it == vths.end()){
    throw runtime_error("vth can't find");
  }
  //proc->vth = it->second;
  proc->aging_time = time;
}
double Sim::get_Vth_max(){
  double Vth_max = 0.0;
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    if(Vth_max < Processor_List[i]->vth){
      Vth_max = Processor_List[i]->vth;
    }
  }
  return Vth_max;
}
double Sim::get_Vth_min(){
  double Vth_min = 1000;
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    if(Vth_min > Processor_List[i]->vth){
      Vth_min = Processor_List[i]->vth;
    }
  }
  return Vth_min;
}
bool Sim::SpareCoreAssignment(Task *task){
  sort(Processor_List.begin(), Processor_List.end(), operate_time_cmp);
  sort(Processor_List.begin(), Processor_List.end(), spare_core_cmp);
  vector<TaskInfo > sloutions;
  unsigned int i = 0;
  //if(isOpen && task->isCritical){
  if(task->isCritical){
    i = 0;
  }
  else{
    i = 1;
  }
  for(; i < Processor_List.size() ; ++i){
    for(unsigned int j = 0 ; j < voltages.size() ; ++j){
      map<string, map<string, Info*> >::iterator it = task->map_voltage_time.find(voltages[j]->voltage_str);
      if(it == task->map_voltage_time.end() ){
        throw runtime_error("can't find");
      }
      map<string, Info*>::iterator itt = it->second.find(Processor_List[i]->aging_time);
      if(itt == it->second.end() ){
        cout << "Processor "<< Processor_List[i]->index <<" is "<<Processor_List[i]->aging_time << endl;
        throw runtime_error("proc aging time can't find");
      }
      TaskInfo taskInfo;
      taskInfo.Energy_d = 0.0;
      taskInfo.Energy_i = 0.0;
      taskInfo.Energy_t = 0.0;
      taskInfo.dl_idle_energy = 0.0;
      taskInfo.earliest_start_time = max(task->ready_time, Processor_List[i]->available_time);
      taskInfo.ready_time = task->ready_time;
      taskInfo.v.voltage = voltages[j]->voltage;
      taskInfo.v.voltage_str = voltages[j]->voltage_str;
      taskInfo.proc_index = Processor_List[i]->index;
      taskInfo.proc = Processor_List[i];
      taskInfo.delay = itt->second->delay;
      taskInfo.dynamic_power = itt->second->avg_power;
      taskInfo.exec_time = ((double)task->cycle) * itt->second->delay;
      taskInfo.slack = task->deadline_time - taskInfo.earliest_start_time - taskInfo.exec_time;
      taskInfo.cost = 99999.9;
      if(taskInfo.slack >= 0.0){
        sloutions.push_back(taskInfo); 
      }           
    } 
    if(sloutions.size() > 0){
      break;
    }
  }
  if(sloutions.size() > 0){
    sort(sloutions.begin(), sloutions.end(), slack_cmp);
  }
  /*
  else if(!isOpen){
    isOpen = true;
    for(unsigned int j = 0 ; j < voltages.size() ; ++j){
      map<string, map<string, Info*> >::iterator it = task->map_voltage_time.find(voltages[j]->voltage_str);
      if(it == task->map_voltage_time.end() ){
        throw runtime_error("can't find");
      }
      map<string, Info*>::iterator itt = it->second.find(Processor_List[0]->aging_time);
      if(itt == it->second.end() ){
        cout << "Processor "<< Processor_List[0]->index <<" is "<<Processor_List[0]->aging_time << endl;
        throw runtime_error("proc aging time can't find");
      }
      TaskInfo taskInfo;
      taskInfo.Energy_d = 0.0;
      taskInfo.Energy_i = 0.0;
      taskInfo.Energy_t = 0.0;
      taskInfo.dl_idle_energy = 0.0;
      taskInfo.earliest_start_time = max(task->ready_time, Processor_List[0]->available_time);
      taskInfo.ready_time = task->ready_time;
      taskInfo.v.voltage = voltages[j]->voltage;
      taskInfo.v.voltage_str = voltages[j]->voltage_str;
      taskInfo.proc_index = Processor_List[0]->index;
      taskInfo.proc = Processor_List[0];
      taskInfo.delay = itt->second->delay;
      taskInfo.dynamic_power = itt->second->avg_power;
      taskInfo.exec_time = ((double)task->cycle) * itt->second->delay;
      taskInfo.slack = task->deadline_time - taskInfo.earliest_start_time - taskInfo.exec_time;
      taskInfo.cost = 99999.9;
      if(taskInfo.slack >= 0.0){
        sloutions.push_back(taskInfo);
        break;        
      }           
    }
  }*/
  else{
    return 0;
  }
  sloutions.front().Energy_d = sloutions.front().dynamic_power * sloutions.front().exec_time;
  double idle_power = idle_voltage_time.find(voltages[0]->voltage_str)->second.find( (sloutions.front().proc)->aging_time)->second;
  sloutions.front().dl_idle_energy = idle_power * sloutions.front().slack;
  sloutions.front().Energy_i = sloutions.front().dl_idle_energy;
  if(task->ready_time > (sloutions.front().proc)->available_time){
    double idle_time = (task->ready_time - (sloutions.front().proc)->available_time);
    //(*p_it)->idle_time += idle_time;
    sloutions.front().Energy_i += (idle_power * idle_time);
  }
  sloutions.front().Energy_t = sloutions.front().Energy_d + sloutions.front().Energy_i;

  double finish_time = sloutions.front().earliest_start_time + sloutions.front().exec_time;
  if(finish_time > task->deadline_time){
    throw runtime_error("impossible");
  }
  //debug information
  DebugInfo debugInfo;
  debugInfo.id                = task->id;
  debugInfo.proc_index        = sloutions.front().proc_index;
  debugInfo.aging_time        = (sloutions.front().proc)->aging_time;
  debugInfo.ready_time        = task->ready_time * NS;
  debugInfo.last_start_time   = task->last_start_time * NS;
  debugInfo.deadline_time     = task->deadline_time;
  debugInfo.voltage           = sloutions.front().v.voltage;
  debugInfo.delay             = sloutions.front().delay * NS;
  debugInfo.dynamic_power     = sloutions.front().dynamic_power * NS;
  debugInfo.exec_time         = sloutions.front().exec_time * NS;
  debugInfo.finish_time       = finish_time * NS;
  debugInfo.Energy_t          = (sloutions.front().Energy_t - sloutions.front().dl_idle_energy) * NS * NS; 
  debugList.push_back(debugInfo);
  //update core's information, ex. available time, total power, operate time
  (sloutions.front().proc)->available_time = sloutions.front().earliest_start_time + sloutions.front().exec_time;
  (sloutions.front().proc)->total_power += (sloutions.front().Energy_t - sloutions.front().dl_idle_energy);
  (sloutions.front().proc)->operate_time += sloutions.front().exec_time;
 
  //update the NBTI of core
  compute_delta_vth( sloutions.front().proc, sloutions.front().v.voltage_str, sloutions.front().exec_time * NS);

  //check whether the next task is ready or not
  for(unsigned int i = 0 ; i < task->next.size() ; ++i){
    Task *next = task->next[i];
    next->num_pre--;
    if(finish_time > next->ready_time){
      next->ready_time = finish_time;
    }
    if(next->num_pre == 0 && next->id != END_TASK){
      readyQuere.push_back(next);
    }
  }
  return 1;  
}
bool Sim::VariationAwareTaskToCoreAssignment(Task *task){
  sort(Processor_List.begin(), Processor_List.end(), operate_time_cmp);
  vector<TaskInfo > sloutions;
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    if(task->isCritical){
      map<string, map<string, Info*> >::iterator it = task->map_voltage_time.find(voltages.back()->voltage_str);
      if(it == task->map_voltage_time.end() ){
        throw runtime_error("can't find");
      }
      map<string, Info*>::iterator itt = it->second.find(Processor_List[i]->aging_time);
      if(itt == it->second.end() ){
        cout << "Processor "<< Processor_List[i]->index <<" is "<<Processor_List[i]->aging_time << endl;
        throw runtime_error("proc aging time can't find");
      }
      TaskInfo taskInfo;
      taskInfo.Energy_d = 0.0;
      taskInfo.Energy_i = 0.0;
      taskInfo.Energy_t = 0.0;
      taskInfo.dl_idle_energy = 0.0;
      taskInfo.earliest_start_time = max(task->ready_time, Processor_List[i]->available_time);
      taskInfo.ready_time = task->ready_time;
      taskInfo.v.voltage = voltages.back()->voltage;
      taskInfo.v.voltage_str = voltages.back()->voltage_str;
      taskInfo.proc_index = Processor_List[i]->index;
      taskInfo.proc = Processor_List[i];
      taskInfo.delay = itt->second->delay;
      taskInfo.dynamic_power = itt->second->avg_power;
      taskInfo.exec_time = ((double)task->cycle) * itt->second->delay;
      taskInfo.slack = task->deadline_time - taskInfo.earliest_start_time - taskInfo.exec_time;
      taskInfo.cost = 99999.9;
      if(taskInfo.slack >= 0.0){
        sloutions.push_back(taskInfo); 
      }       
    }
    else{//task is non-critical
      for(unsigned int j = 0 ; j < voltages.size() ; ++j){
        map<string, map<string, Info*> >::iterator it = task->map_voltage_time.find(voltages[j]->voltage_str);
        if(it == task->map_voltage_time.end() ){
          throw runtime_error("can't find");
        }
        map<string, Info*>::iterator itt = it->second.find(Processor_List[i]->aging_time);
        if(itt == it->second.end() ){
          cout << "Processor "<< Processor_List[i]->index <<" is "<<Processor_List[i]->aging_time << endl;
          throw runtime_error("proc aging time can't find");
        }
        TaskInfo taskInfo;
        taskInfo.Energy_d = 0.0;
        taskInfo.Energy_i = 0.0;
        taskInfo.Energy_t = 0.0;
        taskInfo.dl_idle_energy = 0.0;
        taskInfo.earliest_start_time = max(task->ready_time, Processor_List[i]->available_time);
        taskInfo.ready_time = task->ready_time;
        taskInfo.v.voltage = voltages[j]->voltage;
        taskInfo.v.voltage_str = voltages[j]->voltage_str;
        taskInfo.proc_index = Processor_List[i]->index;
        taskInfo.proc = Processor_List[i];
        taskInfo.delay = itt->second->delay;
        taskInfo.dynamic_power = itt->second->avg_power;
        taskInfo.exec_time = ((double)task->cycle) * itt->second->delay;
        taskInfo.slack = task->deadline_time - taskInfo.earliest_start_time - taskInfo.exec_time;
        taskInfo.cost = 99999.9;
        if(taskInfo.slack >= 0.0){
          sloutions.push_back(taskInfo); 
        }           
      }    
    }
    if(sloutions.size() > 0){
      break;
    }
  }
  if(sloutions.size() > 0){
    sort(sloutions.begin(), sloutions.end(), slack_cmp);
  }
  else{
    return 0;
  }
  sloutions.front().Energy_d = sloutions.front().dynamic_power * sloutions.front().exec_time;
  double idle_power = idle_voltage_time.find(voltages[0]->voltage_str)->second.find( (sloutions.front().proc)->aging_time)->second;
  sloutions.front().dl_idle_energy = idle_power * sloutions.front().slack;
  sloutions.front().Energy_i = sloutions.front().dl_idle_energy;
  if(task->ready_time > (sloutions.front().proc)->available_time){
    double idle_time = (task->ready_time - (sloutions.front().proc)->available_time);
    //(*p_it)->idle_time += idle_time;
    sloutions.front().Energy_i += (idle_power * idle_time);
  }
  sloutions.front().Energy_t = sloutions.front().Energy_d + sloutions.front().Energy_i;

  double finish_time = sloutions.front().earliest_start_time + sloutions.front().exec_time;
  if(finish_time > task->deadline_time){
    throw runtime_error("impossible");
  }
  //debug information
  DebugInfo debugInfo;
  debugInfo.id                = task->id;
  debugInfo.proc_index        = sloutions.front().proc_index;
  debugInfo.aging_time        = (sloutions.front().proc)->aging_time;
  debugInfo.ready_time        = task->ready_time * NS;
  debugInfo.last_start_time   = task->last_start_time * NS;
  debugInfo.deadline_time     = task->deadline_time;
  debugInfo.voltage           = sloutions.front().v.voltage;
  debugInfo.delay             = sloutions.front().delay * NS;
  debugInfo.dynamic_power     = sloutions.front().dynamic_power * NS;
  debugInfo.exec_time         = sloutions.front().exec_time * NS;
  debugInfo.finish_time       = finish_time * NS;
  debugInfo.Energy_t          = (sloutions.front().Energy_t - sloutions.front().dl_idle_energy) * NS * NS; 
  debugList.push_back(debugInfo);
  //update core's information, ex. available time, total power, operate time
  (sloutions.front().proc)->available_time = sloutions.front().earliest_start_time + sloutions.front().exec_time;
  (sloutions.front().proc)->total_power += (sloutions.front().Energy_t - sloutions.front().dl_idle_energy);
  (sloutions.front().proc)->operate_time += sloutions.front().exec_time;
 
  //update the NBTI of core
  compute_delta_vth( sloutions.front().proc, sloutions.front().v.voltage_str, sloutions.front().exec_time * NS);

  //check whether the next task is ready or not
  for(unsigned int i = 0 ; i < task->next.size() ; ++i){
    Task *next = task->next[i];
    next->num_pre--;
    if(finish_time > next->ready_time){
      next->ready_time = finish_time;
    }
    if(next->num_pre == 0 && next->id != END_TASK){
      readyQuere.push_back(next);
    }
  }
  return 1;  
}
bool Sim::TaskToCoreAssignment(Task *task){  
  sort(Processor_List.begin(), Processor_List.end(), operate_time_cmp);
  //decide the protected cores
  if(isAsymmetric){
    unsigned int tmp_overlap_counter = overlap_counter;
    for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
      if(tmp_overlap_counter > 0){
        Processor_List[i]->isProtect = true;
        tmp_overlap_counter--;
      }
      else{
        Processor_List[i]->isProtect = false;
      }
    }
    sort(Processor_List.begin(), Processor_List.end(), index_cmp);
  }
  vector<vector<TaskInfo> > sloutions_2d;
  vector<TaskInfo > sloutions;
  Vth_max = get_Vth_max();
  Vth_min = get_Vth_min();
  /*Vth_max = 0.584154;
  Vth_min = 0.45;*/
  double alpha = 0.05;
  double beta = 0.95;
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    sloutions_2d.push_back(vector<TaskInfo>() );
    for(unsigned int j = 0 ; j < voltages.size() ; ++j){
      map<string, map<string, Info*> >::iterator it = task->map_voltage_time.find(voltages[j]->voltage_str);
      if(it == task->map_voltage_time.end() ){
        throw runtime_error("can't find");
      }
      map<string, Info*>::iterator itt = it->second.find(Processor_List[i]->aging_time);
      if(itt == it->second.end() ){
        cout << "Processor "<< Processor_List[i]->index <<" is "<<Processor_List[i]->aging_time << endl;
        throw runtime_error("proc aging time can't find");
      }
      TaskInfo taskInfo;
      taskInfo.Energy_d = 0.0;
      taskInfo.Energy_i = 0.0;
      taskInfo.Energy_t = 0.0;
      taskInfo.dl_idle_energy = 0.0;
      taskInfo.earliest_start_time = max(task->ready_time, Processor_List[i]->available_time);
      taskInfo.ready_time = task->ready_time;
      taskInfo.v.voltage = voltages[j]->voltage;
      taskInfo.v.voltage_str = voltages[j]->voltage_str;
      taskInfo.proc_index = Processor_List[i]->index;
      taskInfo.proc = Processor_List[i];
      taskInfo.delay = itt->second->delay;
      taskInfo.dynamic_power = itt->second->avg_power;
      taskInfo.exec_time = ((double)task->cycle) * itt->second->delay;
      taskInfo.slack = task->deadline_time - taskInfo.earliest_start_time - taskInfo.exec_time;
      taskInfo.isAgingSlack = task->deadline_time - task->ready_time - taskInfo.exec_time;
      taskInfo.cost = 99999.9;
      if(isAsymmetric){
        sloutions_2d.back().push_back(taskInfo);
      }
      else{//symmetric
        if(taskInfo.slack >= 0.0){
          sloutions.push_back(taskInfo); 
        }
      }            
    }
    if(isAsymmetric){
    }
    else{//symmetric
      if(sloutions.size() > 0){
        break;
      }
    }
  }
  unsigned int index = 0;
  if(isAsymmetric){
    //compute alpha and beta
    for(unsigned int i = 0 ; i < Processor_List.size() ; i++){
      unsigned int num_violation = 0;
      for(unsigned int j = 0 ; j < voltages.size() ; j++){
        if(sloutions_2d[i][j].slack < 0.0 && sloutions_2d[i][j].ready_time >= sloutions_2d[i][j].earliest_start_time){
        //if(sloutions_2d[i][j].isAgingSlack < 0.0){  
          num_violation++;
        }      
      }
      if(num_violation == voltages.size()){
        continue;
      }
      else{
        alpha = ((double)( (i * voltages.size()) + num_violation + 1 )) / ((double) (voltages.size() * Processor_List.size()) );
        if(alpha > 1.0){
          alpha = 1.0;
        }
        beta = 1.0 - alpha;
        break;  
      }
    }
    /*unsigned int num_violation = 0;
    for(unsigned int i = 0 ; i < Processor_List.size() ; i++){
      for(unsigned int j = 0 ; j < voltages.size() ; j++){
        if(sloutions_2d[i][j].isAgingSlack < 0.0){  
          num_violation++;
        }      
      }
    }    
    alpha = ((double)( num_violation )) / ((double) (voltages.size() * Processor_List.size()) );
    if(alpha > 1.0){
      alpha = 1.0;
    }
    beta = 1.0 - alpha;*/
    //compute the cost value of each solution
    for(unsigned int i = 0 ; i < sloutions_2d.size(); ++i ){
      for(unsigned int j = 0 ; j < sloutions_2d[i].size(); ++j ){
        if(sloutions_2d[i][j].slack >= 0.0){
          sloutions_2d[i][j].cost = alpha * ( ( (sloutions_2d[i][j].proc)->vth - Vth_min )/ Vth_min ) + beta * ( (Vth_max - (sloutions_2d[i][j].proc)->vth)/ Vth_max );
          //sloutions_2d[i][j].cost = alpha * ( ( (sloutions_2d[i][j].proc)->vth - Vth_min ) ) + beta * ( (Vth_max - (sloutions_2d[i][j].proc)->vth) );
          sloutions.push_back(sloutions_2d[i][j]); 
        }     
      }
    }
    //if(isRescheduling){
    //protected_core(sloutions, task);
    //}
    if(sloutions.size() > 1){
      sort(sloutions.begin(), sloutions.end(), cmp);
      sloutions.erase(sloutions.begin()+ (sloutions.size()/2),sloutions.end());
      check_slack(sloutions, task);
    }
    else if(sloutions.size() == 1){
    }
    else{
      return 0;
    }    
  }
  else{//symmetric
    if(sloutions.size() > 0){
      sort(sloutions.begin(), sloutions.end(), slack_cmp);
    }
    else{
      return 0;
    }
  }
  //choose a minimum energy
  if(isAsymmetric){
    double min_vth = 1.7976931348623158e+308;
    double min_energy = 1.7976931348623158e+308;
    for(unsigned int i = 0 ; i < sloutions.size() ; ++i){
      sloutions[i].Energy_d = sloutions[i].dynamic_power * sloutions[i].exec_time;
      if( (sloutions[i].proc)->aging_time == "21y"){
        throw runtime_error("Algorithm2");
      }
      double idle_power = idle_voltage_time.find(voltages[0]->voltage_str)->second.find( (sloutions[i].proc)->aging_time)->second;
      sloutions[i].dl_idle_energy = idle_power * sloutions[i].slack;
      sloutions[i].Energy_i = sloutions[i].dl_idle_energy;
      if(task->ready_time > (sloutions[i].proc)->available_time){
        double idle_time = (task->ready_time - (sloutions[i].proc)->available_time);
        sloutions[i].Energy_i += (idle_power * idle_time);
      } 
      sloutions[i].Energy_t = sloutions[i].Energy_d + sloutions[i].Energy_i;
      double tmp_vth = tmp_compute_delta_vth( sloutions[i].proc, sloutions[i].v.voltage_str, sloutions[i].exec_time * NS);
      if(tmp_vth < min_vth){
        min_vth = tmp_vth;
        index = i;        
      }
      /*if(sloutions[i].Energy_t < min_energy){
        min_energy = sloutions[i].Energy_t;
        index = i;
      }*/
    }   
  }
  else{//symmetric
    sloutions.front().Energy_d = sloutions.front().dynamic_power * sloutions.front().exec_time;
    double idle_power = idle_voltage_time.find(voltages[0]->voltage_str)->second.find( (sloutions.front().proc)->aging_time)->second;
    sloutions.front().dl_idle_energy = idle_power * sloutions.front().slack;
    sloutions.front().Energy_i = sloutions.front().dl_idle_energy;
    if(task->ready_time > (sloutions.front().proc)->available_time){
      double idle_time = (task->ready_time - (sloutions.front().proc)->available_time);
      //(*p_it)->idle_time += idle_time;
      sloutions.front().Energy_i += (idle_power * idle_time);
    }
    sloutions.front().Energy_t = sloutions.front().Energy_d + sloutions.front().Energy_i; 
  }
  
  double finish_time = sloutions[index].earliest_start_time + sloutions[index].exec_time;
  if(finish_time > task->deadline_time){
    throw runtime_error("impossible");
  }
  //debug information
  DebugInfo debugInfo;
  debugInfo.id                = task->id;
  debugInfo.proc_index        = sloutions[index].proc_index;
  debugInfo.aging_time        = (sloutions[index].proc)->aging_time;
  debugInfo.ready_time        = task->ready_time * NS;
  debugInfo.last_start_time   = task->last_start_time * NS;
  debugInfo.deadline_time     = task->deadline_time;
  debugInfo.voltage           = sloutions[index].v.voltage;
  debugInfo.delay             = sloutions[index].delay * NS;
  debugInfo.dynamic_power     = sloutions[index].dynamic_power * NS;
  debugInfo.exec_time         = sloutions[index].exec_time * NS;
  debugInfo.finish_time       = finish_time * NS;
  debugInfo.Energy_t          = (sloutions[index].Energy_t - sloutions[index].dl_idle_energy) * NS * NS; 
  debugList.push_back(debugInfo);
  //update core's information, ex. available time, total power, operate time
  (sloutions[index].proc)->available_time = sloutions[index].earliest_start_time + sloutions[index].exec_time;
  (sloutions[index].proc)->total_power += (sloutions[index].Energy_t - sloutions[index].dl_idle_energy);
  (sloutions[index].proc)->operate_time += sloutions[index].exec_time;
 
  //update the NBTI of core
  compute_delta_vth( sloutions[index].proc, sloutions[index].v.voltage_str, sloutions[index].exec_time * NS);

  //check whether the next task is ready or not
  for(unsigned int i = 0 ; i < task->next.size() ; ++i){
    Task *next = task->next[i];
    next->num_pre--;
    if(finish_time > next->ready_time){
      next->ready_time = finish_time;
    }
    if(next->num_pre == 0 && next->id != END_TASK){
      readyQuere.push_back(next);
    }
  }
  return 1;
}

void Sim::protected_core(vector<TaskInfo > &sloutions, Task *task){
  if( !task->isCritical ){
    //20181027
    if(sloutions.size() > 1){
      sort(sloutions.begin(), sloutions.end(), voltage_cmp);//sort sloutions according voltage from highest to loewst
      vector<TaskInfo >::iterator it = sloutions.begin();
      while(it != sloutions.end() ){
        if(sloutions.size() == 1){
          break;
        }
        else{
          if( Processor_List[(*it).proc_index]->isProtect){//delete protect core from highest voltage
            sloutions.erase(it);
            it = sloutions.begin();
          }
          else{
            it++;
          }
        }
      }         
    }
  } 
}

void Sim::check_slack(vector<TaskInfo > &sloutions, Task *task){
  bool isNextCritical = false;
  for(unsigned int i = 0 ; i < task->next.size() ; ++i){
    if(task->next[i]->isCritical){
      isNextCritical = true;
      break;
    }
  } 
  if(isNextCritical){
    if(sloutions.size() > 1){
      sort(sloutions.begin(), sloutions.end(), slack_cmp);
      vector<TaskInfo >::iterator it = sloutions.begin();
      while(it != sloutions.end() ){
        if(sloutions.size() == 1){
          break;
        }
        else{    
          double total_time = task->deadline_time - (*it).earliest_start_time;
          //cout << ((*it).slack / total_time) << endl;
          if( ( ((*it).slack / total_time) < 0.05 ) && ((*it).v.voltage < 1.2) ){
          //if( ( ((*it).slack * NS) < 5.0) && ((*it).v.voltage < 1.2) ){
            sloutions.erase(it);
            it = sloutions.begin();
          }
          else{
            it++;
          }
        }
      }         
    }
  }  
}
void Sim::computeLastStartTime(Task* task){
  task->last_start_time = 1.7e+308;
  for(unsigned int i = 0 ; i < Processor_List.size() ; ++i){
    if(Processor_List[i]->aging_time == "21y"){
      cout << "Processor "<< i << " aging is 21y" << endl;
      throw runtime_error("impossible case");
    }
    double min_delay = task->map_voltage_time.find(voltages.back()->voltage_str)->second.find(Processor_List[i]->aging_time)->second->delay;
    double min_exec_time = task->cycle * min_delay;// minimun execution time on the processor
    double tmp_last_start_time = task->deadline_time - min_exec_time;		
    if(task->last_start_time > tmp_last_start_time){
      task->last_start_time = tmp_last_start_time;
    }        
  } 
}
Task* Sim::highPriorityTask(){
  Task* highest_task = NULL;
  sort(readyQuere.begin(), readyQuere.end(), ready_cmp); 
  if(readyQuere.size() > 1){
    if(readyQuere[0]->ready_time < readyQuere[1]->ready_time){//minimun ready time task
      computeLastStartTime(readyQuere.front());
      highest_task = readyQuere.front();
    }
    else{//readyQuere[0]->ready_time >= readyQuere[1]->ready_time
      for(unsigned int i = 0 ; i < readyQuere.size() ; ++i){
        computeLastStartTime(readyQuere[i]);
      }
      sort(readyQuere.begin(), readyQuere.end(), last_start_time_cmp);
      highest_task = readyQuere.front();  
    }
  }
  else if(readyQuere.size() == 1 ){// only one task in ready queue
    computeLastStartTime(readyQuere.front());
    highest_task = readyQuere.front();
  }
  else{//readyQueue.empty
    throw runtime_error("impossible case: readyQueue is empty");
  }
  return highest_task;
}
void Sim::random_taskgraph(string str_benchmark_name, int policy){
  vector<vector<backupTaskInfo> > backupTaskList;
  unsigned int max_overlap = 0;

  for(unsigned int i = 0 ; i < critical_list.size(); ++i){
    backupTaskList.push_back(vector<backupTaskInfo>() );
  
    //=======將task graph給initial
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      sorted_List[j]->deadline_time = 0.0;
      sorted_List[j]->ratio = 0.0;
      sorted_List[j]->ready_time = 0.0;
      sorted_List[j]->ready_time_backup = 0.0;
      sorted_List[j]->isRelease = false;      
      sorted_List[j]->isCritical = false; 
      sorted_List[j]->isTight = false;
      backupTaskInfo temp;
      backupTaskList[i].push_back(temp);
    } 
    
    setDeadline(critical_list[i]);

    if(isRescheduling){
      reScheduling();
    }
    else{
      overlap_counter = checkCriticalOverlap();
    }  
    if(overlap_counter > max_overlap){
      max_overlap = overlap_counter;
    }
    //set the task of task graph to critical or non-critical
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      //cout << sorted_List[k]->id << " "<< sorted_List[k]->ratio << " " << sorted_List[k]->isTight << endl;
      if(sorted_List[j]->ratio == critical_ratio ){
        sorted_List[j]->isCritical = true;
      }
      else if( sorted_List[j]->ratio < nonCritical_ratio ){
        sorted_List[j]->isCritical = true;
      }
      else{
        sorted_List[j]->isCritical = false;
      }
    }
    //set the period of task graph
    double temp_period = 0.0;
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      if(sorted_List[j]->deadline_time > temp_period){
        temp_period = sorted_List[j]->deadline_time;
      }   
    } 
  
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      backupTaskList[i][j].id             = sorted_List[j]->id;   
      backupTaskList[i][j].deadline_time  = sorted_List[j]->deadline_time;
      backupTaskList[i][j].ratio          = sorted_List[j]->ratio;
      backupTaskList[i][j].isCritical     = sorted_List[j]->isCritical;
      backupTaskList[i][j].period         = temp_period;
      backupTaskList[i][j].overlap_counter= max_overlap;
    }  
    reset();//reset simulator, including core, task graph
  }
  
  string wfile_name = "./result/" + str_benchmark_name;
  mkdir(wfile_name.c_str(), 0777);
  wfile_name += "/random";
  mkdir(wfile_name.c_str(), 0777);
  string policy_name = "";
  
  switch(policy){
    case 0:
      isAsymmetric = false;
      isRescheduling = false;
      policy_name = "Symmetric";
      break;
    case 1:
      isAsymmetric = false;
      isRescheduling = false;
      policy_name = "Variation_Aware";
      break;
    case 2:
      isAsymmetric = false;
      isRescheduling = false;
      policy_name = "spare_core";
      break;              
    case 3:
      isAsymmetric = true;
      isRescheduling = false; 
      policy_name = "Asymmetric";
      break;           
    case 4:
      isAsymmetric = true;
      isRescheduling = true;
      policy_name = "Reschduling_Asymmetric";
      break;
  }
  string w_policy_name = wfile_name + "/" + policy_name + ".log";
  wfile_name += "/" + policy_name + ".csv";
  cout << wfile_name << endl;
  wfile.open(wfile_name.c_str(), ios::out);//open
  w_policy_file.open(w_policy_name.c_str(), ios::out);//open
  
  bool isEnd = false;
  while(!isEnd){
    //random a task graph
    unsigned int random_index = rand() % (critical_list.size()); 
    for(unsigned int i = 0 ; i < backupTaskList[random_index].size() ; ++i){
      sorted_List[i]->deadline_time     = backupTaskList[random_index][i].deadline_time;
      sorted_List[i]->ratio             = backupTaskList[random_index][i].ratio;
      sorted_List[i]->isCritical        = backupTaskList[random_index][i].isCritical;    
      period                            = backupTaskList[random_index][i].period; //set the period of task graph
      overlap_counter                   = backupTaskList[random_index][i].overlap_counter;
    }
    
    for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
      Processor_List[j]->available_time = 0.0;
      Processor_List[j]->total_power = 0.0;
      Processor_List[j]->operate_time = 0.0;
    }
    //for each period, we need to reset the ready time of each task 
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      if(sorted_List[j]->id == 0 || sorted_List[j]->id == END_TASK){
        sorted_List[j]->ready_time = 0.0;
        sorted_List[j]->ready_time_backup = 0.0;           
      }
      else if(sorted_List[j]->id != START_TASK && sorted_List[j]->id != START_TASK2){//not the first task
      //else if(sorted_List[j]->id != START_TASK){//not the first task
        sorted_List[j]->ready_time = -1.0;
        sorted_List[j]->ready_time_backup = -1.0;  
      }
    }
    //if tasks can be execute, push it into ready queue      
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      //reset the dependency of task
      sorted_List[j]->num_pre = sorted_List[j]->num_pre_backup;
      if(sorted_List[j]->id != 0 && sorted_List[j]->id != END_TASK){
        if(sorted_List[j]->ready_time == 0.0){
          readyQuere.push_back(sorted_List[j]);
        }
      }    
    }
    //reset the debugList      
    debugList.clear();
    //for each period, do
    while(readyQuere.size() != 0){
      //get a highest priority task
      Task *highest_task = highPriorityTask();
      if(highest_task == NULL){
        throw runtime_error("highest_task == NULL");
        isEnd = true;
        break;
      }
      bool success = false;
      if(policy == 1 ){
        success = VariationAwareTaskToCoreAssignment(highest_task);
      }
      else if(policy == 2){
        success = SpareCoreAssignment(highest_task);
      }
      else if(policy == 0 || policy == 3 || policy == 4){
        success = TaskToCoreAssignment(highest_task);
      }
      if(!success){
        print_debugList(debugList);
        wfile << "task id: " << highest_task->id << endl;
        wfile << " ready time is: " << highest_task->ready_time * NS << endl;
        wfile << " last_start_time is: " << highest_task->last_start_time * NS << endl;
        wfile << " deadline time is: " << highest_task->deadline_time * NS << endl;
        for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
          wfile << "core "<< Processor_List[j]->index <<": "<<Processor_List[j]->available_time * NS << endl; 
        }
        isEnd = true;
        break;            
      }
    readyQuere.erase(readyQuere.begin());
    }
    //update the simulator operate time
    this->operate_time = this->operate_time + period;
    //update simulator's information, ex. energy and total operate time
    for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
      if(period > Processor_List[j]->available_time){
        map<string, map<string,double> >::iterator it = idle_voltage_time.find(voltages[0]->voltage_str); 
        map<string,double>::iterator itt = it->second.find(Processor_List[j]->aging_time);
        //if aging time is exceed observation window
        if(itt == it->second.end()){
          throw runtime_error("impossible case: because before update NBTI");
        }
        //compute idle power of each core if needed
        double idle_power = itt->second;
        Processor_List[j]->total_power =  Processor_List[j]->total_power + (idle_power * (period - Processor_List[j]->available_time) );
      }
      total_energy += Processor_List[j]->total_power * NS_SQ;
      total_operate_time += Processor_List[j]->operate_time * NS;
    }  
    //simulation_time =  (this->operate_time * NS) / 31536000.0;
    simulation_time = (this->operate_time * 31.7097919); // 31.7097919 is about to NS / 31536000
    stringstream ss, mm;
    string int2str;
    if(simulation_time < 1){
      unsigned int j = 0;
      while(j < months.size()){
        if(simulation_time < months[j]){
          break;
        }      
        ++j;
      }
      ss << j;
      int2str = ss.str() + "m";
    }
    else{
      double tmp_simulation_time = simulation_time;
      ss << (int)simulation_time;
      while(tmp_simulation_time >= 1){
        tmp_simulation_time = tmp_simulation_time - 1;
      }
      unsigned int j = 0;
      while(j < months.size()){
        if(tmp_simulation_time < months[j]){
          break;
        }      
        ++j;
      }
      mm << j;      
      int2str = ss.str() + "y_" + mm.str() + "m";
    }
    
    //update simulator's information and each core's NBTI
    
    for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
      if( !update(Processor_List[j]) ){
          isEnd = true;
      }
    }
    if(isEnd){//stop in timing violation or core's aging effect
      if(aging_time == ""){
        aging_time = "0m";
      }
      print();
    }
    else if(aging_time != int2str){
      aging_time = int2str;
      print();
    }
  }
  
  wfile.close();
  w_policy_file.close();
  //vth_file.close();
  
}
void Sim::fix_taskgraph(string str_benchmark_name, int policy){
  for(unsigned int i = 0 ; i < critical_list.size(); ++i){//for每一個case i.e., (1,2) or (1,3)
    string wfile_name = "./result/" + str_benchmark_name;
    mkdir(wfile_name.c_str(), 0777);
    string policy_name = "";
    stringstream ss;    
    ss << critical_list[i].size();
    string str = ss.str();
    wfile_name += "/" + str;
    mkdir(wfile_name.c_str(), 0777);
    wfile_name += "/Task";
    string wfile_name_backup = wfile_name;
    switch(policy){
      case 0:
        isAsymmetric = false;
        isRescheduling = false;
        policy_name = "Symmetric";
        break;
      case 1:
        isAsymmetric = false;
        isRescheduling = false;
        policy_name = "Variation_Aware";
        break;
      case 2:
        isAsymmetric = false;
        isRescheduling = false;
        policy_name = "spare_core";
        break;              
      case 3:
        isAsymmetric = true;
        isRescheduling = false; 
        policy_name = "Asymmetric";
        break;           
      case 4:
        isAsymmetric = true;
        isRescheduling = true;
        policy_name = "Reschduling_Asymmetric";
        break;
    }
    for(unsigned int j = 0 ; j < critical_list[i].size() ; ++j){
      stringstream ss;
      ss << critical_list[i][j];
      string str = "";
      if(j < critical_list[i].size()-1)
        str = ss.str() + "_";
      else
        str = ss.str();
      wfile_name += str;
    }
    mkdir(wfile_name.c_str(), 0777);
    string w_policy_name = wfile_name + "/" + policy_name + ".log";
    wfile_name += "/" + policy_name + ".csv";
    
    cout << wfile_name << endl;
    wfile.open(wfile_name.c_str(), ios::out);//open
    w_policy_file.open(w_policy_name.c_str(), ios::out);//open
    /*string vth_file_name = "vth_" + policy_name + ".csv";
    vth_file.open(vth_file_name.c_str(),ios::out);//open
    vth_file <<",";
    for(unsigned int j = 0 ; j < Processor_List.size(); ++j){
      vth_file <<"core" << j << ",";
    }
    vth_file << endl;*/
    wfile <<"Critical task: ";
    for(unsigned int j = 0 ; j < critical_list[i].size() ; ++j){
      wfile << critical_list[i][j] << " ";
    }     
    wfile << endl << endl;
    wfile << "Critical ratio: "<< critical_ratio << endl;
    wfile << "nonCritical ratio: "<< nonCritical_ratio << endl;
    wfile << endl << endl;
    
    reset();//reset simulator, including core, task graph

    //set task graph deadline 
    setDeadline(critical_list[i]); 
    if(isRescheduling){
      reScheduling();
    }
    else{
      overlap_counter = checkCriticalOverlap();
    }
    //set the task of task graph to critical or non-critical
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      //cout << sorted_List[k]->id << " "<< sorted_List[k]->ratio << " " << sorted_List[k]->isTight << endl;
      if(sorted_List[j]->ratio == critical_ratio ){
        sorted_List[j]->isCritical = true;
      }
      else if( sorted_List[j]->ratio < nonCritical_ratio ){
        sorted_List[j]->isCritical = true;
      }
      else{
        sorted_List[j]->isCritical = false;
      }
    }
    //set the period of task graph
    for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
      if(sorted_List[j]->deadline_time > period){
        period = sorted_List[j]->deadline_time;
      }   
    }
    
    bool isEnd = false;
    while(!isEnd){
      for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
        Processor_List[j]->available_time = 0.0;
        Processor_List[j]->total_power = 0.0;
        Processor_List[j]->operate_time = 0.0;
      }
      //for each period, we need to reset the ready time of each task 
      for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
        if(sorted_List[j]->id == 0 || sorted_List[j]->id == END_TASK){
          sorted_List[j]->ready_time = 0.0;
          sorted_List[j]->ready_time_backup = 0.0;           
        }
        else if(sorted_List[j]->id != START_TASK && sorted_List[j]->id != START_TASK2){//not the first task
        //else if(sorted_List[j]->id != START_TASK){//not the first task
          sorted_List[j]->ready_time = -1.0;
          sorted_List[j]->ready_time_backup = -1.0;  
        }
      }
      //if tasks can be execute, push it into ready queue      
      for(unsigned int j = 0 ; j < sorted_List.size() ; ++j){
        //reset the dependency of task
        sorted_List[j]->num_pre = sorted_List[j]->num_pre_backup;
        if(sorted_List[j]->id != 0 && sorted_List[j]->id != END_TASK){
          if(sorted_List[j]->ready_time == 0.0){
            readyQuere.push_back(sorted_List[j]);
          }
        }    
      }
      //reset the debugList      
      debugList.clear();
      //for each period, do
      while(readyQuere.size() != 0){
        //get a highest priority task
        Task *highest_task = highPriorityTask();
        if(highest_task == NULL){
          throw runtime_error("highest_task == NULL");
          isEnd = true;
          break;
        }
        bool success = false;
        if(policy == 1 ){
          success = VariationAwareTaskToCoreAssignment(highest_task);
        }
        else if(policy == 2){
          success = SpareCoreAssignment(highest_task);
        }
        else if(policy == 0 || policy == 3 || policy == 4){
          success = TaskToCoreAssignment(highest_task);
        }
        if(!success){
          print_debugList(debugList);
          wfile << "task id: " << highest_task->id << endl;
          wfile << " ready time is: " << highest_task->ready_time * NS << endl;
          wfile << " last_start_time is: " << highest_task->last_start_time * NS << endl;
          wfile << " deadline time is: " << highest_task->deadline_time * NS << endl;
          for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
            wfile << "core "<< Processor_List[j]->index <<": "<<Processor_List[j]->available_time * NS << endl; 
          }
          isEnd = true;
          break;            
        }
	     readyQuere.erase(readyQuere.begin());
      }
      //update the simulator operate time
      this->operate_time = this->operate_time + period;
      //update simulator's information, ex. energy and total operate time
      for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
        if(period > Processor_List[j]->available_time){
          map<string, map<string,double> >::iterator it = idle_voltage_time.find(voltages[0]->voltage_str); 
          map<string,double>::iterator itt = it->second.find(Processor_List[j]->aging_time);
          //if aging time is exceed observation window
          if(itt == it->second.end()){
            throw runtime_error("impossible case: because before update NBTI");
          }
          //compute idle power of each core if needed
          double idle_power = itt->second;
          Processor_List[j]->total_power =  Processor_List[j]->total_power + (idle_power * (period - Processor_List[j]->available_time) );
        }
        total_energy += Processor_List[j]->total_power * NS_SQ;
        total_operate_time += Processor_List[j]->operate_time * NS;
      }  
      //simulation_time =  (this->operate_time * NS) / 31536000.0;
      simulation_time = (this->operate_time * 31.7097919); // 31.7097919 is about to NS / 31536000
      stringstream ss, mm;
      string int2str;
      if(simulation_time < 1){
        unsigned int j = 0;
        while(j < months.size()){
          if(simulation_time < months[j]){
            break;
          }      
          ++j;
        }
        ss << j;
        int2str = ss.str() + "m";
      }
      else{
        double tmp_simulation_time = simulation_time;
        ss << (int)simulation_time;
        while(tmp_simulation_time >= 1){
          tmp_simulation_time = tmp_simulation_time - 1;
        }
        unsigned int j = 0;
        while(j < months.size()){
          if(tmp_simulation_time < months[j]){
            break;
          }      
          ++j;
        }
        mm << j;      
        int2str = ss.str() + "y_" + mm.str() + "m";
      }
      
      //update simulator's information and each core's NBTI
      
      for(unsigned int j = 0 ; j < Processor_List.size() ; ++j){
	      if( !update(Processor_List[j]) ){
          isEnd = true;
	      }
      }
      if(isEnd){//stop in timing violation or core's aging effect
        if(aging_time == ""){
          aging_time = "0m";
        }
        print();
      }
      else if(aging_time != int2str){
        aging_time = int2str;
        print();
      }
    }
    
    wfile.close();
    w_policy_file.close();
  }
}
void Sim::start_map(char *benchmark_name, char *char_policy){
  string str_benchmark_name = benchmark_name;
  int policy = atoi(char_policy);
  if(true){
    /*clock_t start, end;
    double cpu_time_used;
    start = clock();*/
    fix_taskgraph(str_benchmark_name, policy);
    /*end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    cout << cpu_time_used << endl;
    throw runtime_error("stop");*/
  }
  else{
    random_taskgraph(str_benchmark_name, policy);
  }
}
void Sim::topological_ordering(){
  queue<Task *> Q;
  for(unsigned int i = 0 ; i < List.size() ; ++i){
    if(List[i]->num_pre == 0){
      Q.push(List[i]);
    }
  }
  for(unsigned int i = 0 ; i < List.size() ; ++i){
    if(Q.empty()){
      cout << "cycle!!!!" << endl;
      break;
    }
    Task *task = Q.front();
    Q.pop();
    sorted_List.push_back(task);
    for(unsigned int j = 0 ; j < task->next.size() ; ++j){
      Task *next = task->next[j];
      next->num_pre--;
      if(next->num_pre == 0){
        Q.push(next);
      }
    }
  }
  /*for(unsigned int i = 0 ; i < sorted_List.size() ; ++i){
    cout << sorted_List[i]->id << endl;
  }    
  throw runtime_error("stop");*/
}