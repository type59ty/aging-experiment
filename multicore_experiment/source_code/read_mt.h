#ifndef READ_MT
#define READ_MT
#include <string>
#include <fstream>
#include <iostream>
#include <vector>
#include <map>
#include <iomanip>
#include <cstdlib>
#include <sstream>
#include <algorithm>
#include <stdexcept>
using namespace std;

class MT{
public:
  string name;
  double value;
private:
};

class ReadMT{
public:
  ReadMT();
  ReadMT(string file_name, vector<string> input_port, vector<string> output_port);
  ~ReadMT();
  double getValue(string key);
  double computeDelay(int Frequency_int, int Num_Iv);
private:
  void ParseMT(string file_name);
  string Parseline(string &line);
  map<string, double> MTmap;
  vector<MT> MTs;
  vector<string> input_port;
  vector<string> output_port;
  ifstream file;
};
#endif