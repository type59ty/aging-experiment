#ifndef SIM
#define SIM
#include <vector>
#include <queue>
#include "read_mt.h"
#include "task.h"
#include <iostream>
#include <cmath>
#include <time.h>
#include <stdexcept>
#include "getTaskProfile.h"
#include <sys/stat.h>
using namespace std;

class DebugInfo{
public:
  int id;
  int proc_index;
  string aging_time;
  double ready_time;
  double last_start_time;
  double deadline_time;
  double voltage;
  double delay;
  double dynamic_power;
  double exec_time;
  double finish_time;
  double Energy_t; 
private:
};

class Processor{
public:
  unsigned int index;
  double available_time;
  double operate_time;
  double idle_time;
  double ori_vth;
  double vth;
  double delta_vth;
  string aging_time; 
  double total_power;
  bool isProtect;
private:
};

class backupTaskInfo{
public:
  int id;
  bool isCritical;
  double deadline_time;
  double ratio;
  double period;
  unsigned int overlap_counter;
private:
};

class TaskInfo{
public:
  double slack;
  double isAgingSlack;
  double exec_time;
  double cost;
  double dynamic_power;
  double delay;
  double Energy_d;//dynamic
  double Energy_i;//idle
  double Energy_t;//total
  voltage_list v;
  unsigned int proc_index;
  Processor *proc;
  double earliest_start_time;
  double ready_time;
  double dl_idle_energy;
private:
}; 

class Sim{
public:
  void reset();
  vector<Task *> readyQuere;
  Task * highPriorityTask();
  void computeLastStartTime(Task* task);
  vector<DebugInfo> debugList;
  void print_debugList(vector<DebugInfo> &debugList);
  Sim(vector<Task *> List, int num_processor, map<string, map<string,double> >&, vector<voltage_list *>&, double, double, vector<vector<unsigned int> >&);
  void topological_ordering();
  void start_map(char *benchmark_name, char *char_policy);
  void fix_taskgraph(string str_benchmark_name, int policy);
  void random_taskgraph(string str_benchmark_name, int policy);
  void set_process_vth(Processor *, string time);
  bool TaskToCoreAssignment(Task *task);
  bool VariationAwareTaskToCoreAssignment(Task *task);
  bool SpareCoreAssignment(Task *task);
  void setDeadline(vector<unsigned int> &);
  bool update(Processor *core);
  double operate_time;
  string aging_time;
  double gamma;
  double period;
  //unsigned int counter;
private:
  fstream wfile, w_policy_file, vth_file;
  double vth_counter;
  bool isOpen;
  void protected_core(vector<TaskInfo > &sloutions, Task *task);
  void check_slack(vector<TaskInfo > &sloutions, Task *task);
  void write_file(string policy);
  void reScheduling();
  void ratioRelease(Task *task, Task *pre_task, double ratio);
  unsigned int checkCriticalOverlap();
  double simulation_time;
  void parse_vth();
  void compute_delta_vth(Processor *, string voltage, double exec_time);
  double tmp_compute_delta_vth(Processor *, string voltage, double exec_time);
  void print();
  map<string, double> vths;
  double Vth_max;
  double Vth_min;
  double get_Vth_max();
  double get_Vth_min();
  double get_protect_Vth_max();
  double get_protect_Vth_min();
  string Parseline(string &line);
  //vector<vector<Task *> > List;
  vector<Task *> List;
  vector<double > months;
  vector<voltage_list * > voltages;
  map<string, map<string,double> > idle_voltage_time;
  vector<Task *> sorted_List;
  
  vector<Task *> critical_List;  
  vector<vector<Task * > > critical_couple_list;
  map<int, vector<Task *> > overlap_task_map;
  vector<Task *> overlap_task_list;
  
  vector<Processor *> Processor_List;
  double total_energy;
  double total_operate_time;
  unsigned int overlap_counter;
  bool isRescheduling;
  bool isAsymmetric;
  vector<vector<unsigned int> > critical_list;//input
  double critical_ratio;
  double nonCritical_ratio;
};
#endif