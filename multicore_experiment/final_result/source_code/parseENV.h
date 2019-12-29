#ifndef ENV_H
#define ENV_H
#include <fstream>
#include <vector>
#include <string>
#include <iostream>
#include <cstdlib>
using namespace std;

class ENV{
 public:
  ENV();
  void start_parse(char *file_name);
  vector<vector<unsigned int> > get_critical_list();
  double get_critical_ratio();
  double get_nonCritical_ratio();
private:
  string parse_line(string &line); 
  vector<vector<unsigned int> > critical_list;
  double critical_ratio;
  double nonCritical_ratio;
};
#endif