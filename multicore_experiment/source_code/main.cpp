#include "read_mt.h"
#include "task.h"
#include "parseSTG.h"
#include "sim.h"
#include "parseENV.h"
#include "getTaskProfile.h"
#include "readTaskProfile.h"
using namespace std;

int main(int argc, char** argv){
  cout.setf(ios::fixed, ios::floatfield);
  cout.precision(10);
  //parse env file
  ENV *env = new ENV();
  env->start_parse(argv[3]);
  //get critical ratio and non_critical ratio
  double critical_ratio = env->get_critical_ratio();
  double nonCritical_ratio = env->get_nonCritical_ratio();
  //get critical task list
  vector<vector<unsigned int> > critical_list = env->get_critical_list();

  //parse task graph
  ParseSTG *parseSTG = new ParseSTG();
  parseSTG->start_parse(argv[4]);
  //get task graph
  vector<vector<Task *> > List;  
  List = parseSTG->get_list();

  //parse benchmark information
  int num_input = atoi(argv[8]);     
  int num_output = atoi(argv[ 9 + num_input]);
  vector<string> input_port;
  vector<string> output_port;
  for(int i  = 0 ; i < num_input ; ++i){
    string str(argv[9 + i]);
    input_port.push_back(str);
  }
  for(int i  = 0 ; i < num_output ; ++i){
    string str(argv[9 +  num_input + 1 + i]); 
    output_port.push_back(str);
  }
  //map task graph to hspice result, ex. delay and power
  GetTaskProfile getTaskProfile(List, input_port, output_port, argv[1], argv[6], argv[7]);

  /*
  vector<voltage_list *> voltages = getTaskProfile.get_voltage_list();
  ReadTaskProfile readTaskProfile(voltages, getTaskProfile.get_time_list());
  readTaskProfile.readfile(argv[1],List[0]);

  //voltage and idle power map
  //map<string, map<string,double> > idle_voltage_time = getTaskProfile.get_idle_voltage_time();
  map<string, map<string,double> > idle_voltage_time = readTaskProfile.get_idle_voltage_time();
  int policy = atoi(argv[5]);
  int num_core = atoi(argv[2]);
  if(policy == 2 ){
    num_core += 1;
  }
  Sim *sim = new Sim(List[0], num_core, idle_voltage_time, voltages, critical_ratio, nonCritical_ratio, critical_list);
  sim->topological_ordering(); 
  sim->start_map(argv[1], argv[5]);
  */
  return 0;
}
