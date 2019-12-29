#ifndef GTP
#define GTP
#include <string>
#include <fstream>
#include "task.h"
#include "read_mt.h"

class voltage_list{
public:
  string voltage_str;
  double voltage;
};
class GetTaskProfile{
public:
  GetTaskProfile(vector<vector<Task *> > List, vector<string> &input_port, vector<string> &output_port, char * benchmark_name, char *Frequency, char *Num_Iv);
  map<string, map<string,double> > get_idle_voltage_time();
  vector<voltage_list * > get_voltage_list();
  vector<string > get_time_list();
private:
  void startGet(char * benchmark_name, char *Frequency, char *Num_Iv);
  int convertTime(string time);
  //vector<Task *> List;
  vector<vector<Task *> > List;
  vector<voltage_list *> voltages;
  vector<string > time;
  map<string, map<string,double> > idle_voltage_time;
  vector<string> input_port;
  vector<string> output_port;
};
#endif