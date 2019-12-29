#ifndef RTP_H
#define RTP_H
#include <string>
#include <fstream>
#include <stdexcept>
#include "task.h"
#include "getTaskProfile.h"
using namespace std;
class ReadTaskProfile{
public:
  ReadTaskProfile(vector<voltage_list *> voltages, vector<string > time);
  void readfile(char* benchmark, vector<Task *> taskList);
  map<string, map<string,double> > get_idle_voltage_time();
private:
  vector<voltage_list *> voltages;
  map<string, map<string,double> > idle_voltage_time;
  string Parseline(string &line);
  vector<string > time;
  ifstream file;
};
#endif