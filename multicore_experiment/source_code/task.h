#ifndef TASK
#define TASK
#include <vector>
#include <map>
#include <cstdlib>
#include <sstream>
using namespace std;
class Info{
public:
  double delay;
  double avg_power;
private:
};
class Task{
public:
  Task();
  ~Task();
  int id;
  int cycle;
  int num_pre;
  int num_pre_backup;
  double ready_time;
  double ready_time_backup;
  double last_start_time;
  double ratio;
  double min_finish_time;
  double deadline_time;
  double min_exec_time;
  bool multithread;
  bool isCritical;
  bool isRelease;
  bool isTight;
  vector<Task *> next;
  vector<Task *> pre;
  map<int ,Task *> map_next;
  map<string, map<string, Info*> > map_voltage_time;
private:
};
#endif