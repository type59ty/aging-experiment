#include "task.h"
Task::Task(){
  id = 0;
  cycle = 0;
  num_pre = 0;
  isCritical = false;
  isTight = false;
  isRelease = false;
  multithread = false;
  num_pre = 0;
  num_pre_backup = 0;
  deadline_time = 0.0;
  min_exec_time = 1000000000.0;
  last_start_time = 0.0;
  ratio = 0.0;
  ready_time = 0.0;
  ready_time_backup = 0.0;
  min_finish_time = 0.0;
}
Task::~Task(){
  /*for(vector<Task *>::iterator it = next.begin() ; it != next.end() ; ++it){
    delete (*it);
  }
  next.clear();   */   
}