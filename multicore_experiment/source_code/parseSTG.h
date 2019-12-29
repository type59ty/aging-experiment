#ifndef PARSESTG
#define PARSESTG
#include <vector>
#include <string>
#include <fstream>
#include <iostream>
#include <cstdlib>
#include "task.h"
using namespace std;
class ParseSTG{
public:
  void start_parse(char *file_name);
  string parse_line(string &line);
  vector<vector<Task *> > get_list();
  //vector<Task *> get_list();
private:
  vector<vector<Task *> > List;
  //vector<Task *> List;
};
#endif