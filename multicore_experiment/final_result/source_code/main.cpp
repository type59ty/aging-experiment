#include "parseENV.h"
#include <iostream>
#include <sstream>
#include <cstdlib>
#include <cmath>
#include <bits/stdc++.h>
using namespace std;
string parse_line(string &line){
  string token("");
  string::size_type  index = 0;
  while(line.size() > 0){
    if((line[index] >= '0'  && line[index] <= '9') || 
       (line[index] == '.') || (line[index] == '_') ||
       (line[index] >= 'a' && line[index] <= 'z')){
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

unsigned int compute_index(vector<string> &list1, vector<string> &list2){
  string time = list1.back();
  unsigned int index = 0;
  while(index < list2.size() ){
    if(time == list2[index]){
      if( index + 1 < list2.size() ){
        if(time == list2[index+1] ){
          index++;
          break;
        }
      }
      break;
    }
    index++;
  }
  return index;  
}
unsigned int min_lifetime_size_index(vector<vector<string> > &list1){
  unsigned int index = 0;
  unsigned int min_size_index = 99999;
  for(unsigned int i = 0 ; i < list1.size() ; ++i){
    if(list1[i].size() < min_size_index){
      min_size_index = list1[i].size();
      index = i;
    }
  }
  if (min_size_index >= 2) {
    if (list1[index][min_size_index-1] == list1[index][min_size_index-2]) {
      min_size_index = min_size_index - 2;
    }
  }
  return min_size_index;  
}
class Combine{
public:
  vector<vector<string> > task_list;
  vector<vector<vector<double> > > lifetime_list;
  vector<vector<vector<double> > > normalized_lifetime_list;
  vector<vector<vector<double> > > energy_list;
  vector<vector<vector<double> > > normalized_energy_list;
private:
};

int main(int argc, char** argv){
  ENV *env = new ENV();
  Combine combine;
  //ex./main --benchmark c432 --num_policy 2 --policy_list symmetric Asymmetric
  if(argc <= 8){
    cout << "ex ./main --benchmark c432 --env_file ./env --num_policy 2 --policy_list symmetric Asymmetric" << endl;
    return 0;
  }
  string benchmark_name = argv[2];
  env->start_parse(argv[4]); // env
  vector<string> policy_list;
  vector<vector<double> > averge_lifetime_list;
  vector<vector<double> > averge_normal_lifetime_list;
  vector<vector<double> > geomean_normal_lifetime_list;
  vector<vector<double> > averge_energy_list;
  vector<vector<double> > averge_normal_energy_list;
  vector<vector<double> > geomean_normal_energy_list;
  for(int i = 0 ; i < atoi(argv[6]); ++i){
    string tmp_str(argv[8 + i]);
    policy_list.push_back(tmp_str);
  }

  vector<vector<unsigned int> > critical_list = env->get_critical_list();
  fstream w_policy_file, combineFile, totalLifetimeFile, totalEnergyFile;

  cout.setf(ios::fixed, ios::floatfield);
  cout.precision(10);
  combineFile.setf(ios::fixed, ios::floatfield);
  combineFile.precision(10);
  totalLifetimeFile.setf(ios::fixed, ios::floatfield);
  totalLifetimeFile.precision(10);
  totalEnergyFile.setf(ios::fixed, ios::floatfield);
  totalEnergyFile.precision(10);
  string last_str = "";

  /*
    //20190321_random
    //new_simulator_20190302
    string rfile_name = "../new_simulator_20190302/result/" + benchmark_name;
    string combine_name = "";
    string policy = "";
    rfile_name += "/random";
    string rfile_name_backup = rfile_name;
    vector<vector<double> > lifetime_list;
    vector<vector<double> > energy_list;
    vector<vector<string> > lifetime_string_list;   
    
    string task_name = "";
  

    combine.lifetime_list.push_back(vector<vector<double> >());
    combine.normalized_lifetime_list.push_back(vector<vector<double> >());
    combine.energy_list.push_back(vector<vector<double> >());
    combine.normalized_energy_list.push_back(vector<vector<double> >());      
    combine.task_list.push_back(vector<string>() );
    averge_lifetime_list.push_back(vector<double>() );
    averge_normal_lifetime_list.push_back(vector<double>());
    averge_energy_list.push_back(vector<double>() );
    averge_normal_energy_list.push_back(vector<double>());
    geomean_normal_energy_list.push_back(vector<double>());
    geomean_normal_lifetime_list.push_back(vector<double>());
    
    combine.lifetime_list.back().push_back(vector<double>());
    combine.normalized_lifetime_list.back().push_back(vector<double>());
    combine.energy_list.back().push_back(vector<double>());
    combine.normalized_energy_list.back().push_back(vector<double>());  
    
  for(unsigned int i = 0 ; i < policy_list.size() ; ++i){
    task_name = "";
    lifetime_list.push_back(vector<double>() );
    lifetime_string_list.push_back(vector<string>() );
    energy_list.push_back(vector<double>() );
    rfile_name = rfile_name_backup;
    policy = policy_list[i];
    
    combine_name = rfile_name + "/combine.csv";
    string r_policy_name = rfile_name + "/" + policy + ".log";
    cout << r_policy_name << endl;
    w_policy_file.open(r_policy_name.c_str(), ios::in);//open 
    if(w_policy_file.is_open()){
      string token = "";
      string line = "";
      while(getline(w_policy_file, line, '\n')){
        token = parse_line(line);
        //cout << token << endl;
        lifetime_string_list.back().push_back(token);//ex. 1y
        token = parse_line(line);
        //cout << token << endl;
        lifetime_list.back().push_back( atof(token.c_str()) );//ex. 31,536,000s
        token = parse_line(line);
        //cout << token << endl;
        energy_list.back().push_back( atof(token.c_str()) ); //ex. 100wt
      }
    }
    w_policy_file.close();
  }
  combineFile.open(combine_name.c_str(), ios::out);
  for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
    combineFile << policy_list[j] << ",";
  }
  combineFile << endl;
  for(unsigned int j = 0 ; j < lifetime_list.size(); ++j ){
    combineFile << lifetime_list[j].back() << ",";
    combine.lifetime_list.back().back().push_back(lifetime_list[j].back());
  }
  for(unsigned int j = 0 ; j < lifetime_list.size() ; ++j){
    combineFile << lifetime_list[j].back() / lifetime_list.front().back() << ",";
    combine.normalized_lifetime_list.back().back().push_back(lifetime_list[j].back() / lifetime_list.front().back() );
  }
  combineFile << endl;  
  unsigned int index  = min_lifetime_size_index(lifetime_string_list);
  for(unsigned int j = 0 ; j < lifetime_list.size(); ++j){
    combineFile << energy_list[j][index] <<",";
    combine.energy_list.back().back().push_back(energy_list[j][index] );
  }
  for(unsigned int j = 0 ; j < lifetime_list.size(); ++j){
    combineFile <<  energy_list[j][index] / energy_list[0][index] <<",";
    combine.normalized_energy_list.back().back().push_back(energy_list[j][index] / energy_list[0][index] );
  }
  combineFile << endl;
  combineFile.close();
  combine.task_list.back().push_back(task_name);
  for(unsigned int i = 0 ; i < averge_lifetime_list.size() ; ++i){// 2, 4, 6
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      averge_lifetime_list[i].push_back(0.0);
      averge_normal_lifetime_list[i].push_back(0.0);
      averge_energy_list[i].push_back(0.0);
      averge_normal_energy_list[i].push_back(0.0);
      geomean_normal_energy_list[i].push_back(1);
      geomean_normal_lifetime_list[i].push_back(1);
    }  
  }
  
  for(unsigned int i = 0 ; i < combine.lifetime_list.size() ; ++i){// 2, 4, 6

    string total_lifetime_file_name = benchmark_name + "_lifetime_random" + ".csv";
    string total_energy_file_name = benchmark_name + "_energy_random" + ".csv";
    totalLifetimeFile.open(total_lifetime_file_name.c_str(), ios::out);
    totalEnergyFile.open(total_energy_file_name.c_str(), ios::out);
    totalLifetimeFile << ",";
    totalEnergyFile <<",";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      totalLifetimeFile << policy_list[j] << ",";
      totalEnergyFile << policy_list[j] << ",";
    }
    totalLifetimeFile << endl;
    totalEnergyFile <<endl;
    for(unsigned int j = 0 ; j < combine.lifetime_list[i].size() ; ++j){//Task1_2....
      totalLifetimeFile << combine.task_list[i][j] << ",";
      totalEnergyFile << combine.task_list[i][j] << ",";
      for(unsigned int k = 0 ; k < combine.normalized_lifetime_list[i][j].size() ; ++k){//policy
        totalLifetimeFile << combine.normalized_lifetime_list[i][j][k] << ",";
        totalEnergyFile << combine.normalized_energy_list[i][j][k] << ",";
        averge_normal_lifetime_list[i][k] += combine.normalized_lifetime_list[i][j][k];
        geomean_normal_lifetime_list[i][k] = geomean_normal_lifetime_list[i][k] * combine.normalized_lifetime_list[i][j][k];
        averge_normal_energy_list[i][k] += combine.normalized_energy_list[i][j][k];
        geomean_normal_energy_list[i][k] = geomean_normal_energy_list[i][k] * combine.normalized_energy_list[i][j][k];
      }
      totalLifetimeFile << ",";
      totalEnergyFile  << ",";      
      for(unsigned int k = 0 ; k < combine.lifetime_list[i][j].size() ; ++k){//policy
        totalLifetimeFile << combine.lifetime_list[i][j][k] << ",";
        totalEnergyFile << combine.energy_list[i][j][k] << ",";
        averge_lifetime_list[i][k] += combine.lifetime_list[i][j][k];
        averge_energy_list[i][k] += combine.energy_list[i][j][k];
      }
      totalLifetimeFile << endl;
      totalEnergyFile << endl;
    }
    totalLifetimeFile << endl;
    totalEnergyFile << endl;
    double num_case = combine.lifetime_list[i].size() ;
    totalLifetimeFile << ",";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      //totalLifetimeFile << averge_normal_lifetime_list[i][j] / num_case<< ",";   
      totalLifetimeFile << pow(geomean_normal_lifetime_list[i][j], 1.0/num_case) << ",";
    }
    totalLifetimeFile << ",,";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      totalLifetimeFile << averge_lifetime_list[i][j] / 31536000.0 / num_case<< ",";   
    }
    totalEnergyFile << ",";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      //totalEnergyFile << averge_normal_energy_list[i][j] / num_case<< ",";
      totalEnergyFile << pow(geomean_normal_energy_list[i][j], 1.0/num_case) << ",";
    }
    totalEnergyFile << ",,";
     
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      totalEnergyFile << averge_energy_list[i][j] /  num_case<< ",";  
    }    
    totalLifetimeFile.close();
    totalEnergyFile.close();
  }
  return 0;*/
  //////////////////////////
  for(unsigned int i = 0 ; i < critical_list.size(); ++i){
    //20190321_random
    //new_simulator_20190302
    string rfile_name = "../result/" + benchmark_name;
    string combine_name = "";
    string policy = "";
    stringstream ss;    
    ss << critical_list[i].size();
    string tmp_str = ss.str();
    rfile_name += "/" + tmp_str + "/Task";
    string rfile_name_backup = rfile_name;
    vector<vector<double> > lifetime_list;
    vector<vector<double> > energy_list;
    vector<vector<string> > lifetime_string_list;   
    
    string task_name = "";
  
    if( tmp_str != last_str){
      combine.lifetime_list.push_back(vector<vector<double> >());
      combine.normalized_lifetime_list.push_back(vector<vector<double> >());
      combine.energy_list.push_back(vector<vector<double> >());
      combine.normalized_energy_list.push_back(vector<vector<double> >());      
      combine.task_list.push_back(vector<string>() );
      averge_lifetime_list.push_back(vector<double>() );
      averge_normal_lifetime_list.push_back(vector<double>());
      geomean_normal_lifetime_list.push_back(vector<double>());
      averge_energy_list.push_back(vector<double>() );
      averge_normal_energy_list.push_back(vector<double>());
      geomean_normal_energy_list.push_back(vector<double>());
    }
    last_str = tmp_str;
    combine.lifetime_list.back().push_back(vector<double>());
    combine.normalized_lifetime_list.back().push_back(vector<double>());
    combine.energy_list.back().push_back(vector<double>());
    combine.normalized_energy_list.back().push_back(vector<double>());   
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      task_name = "Task";
      lifetime_list.push_back(vector<double>() );
      lifetime_string_list.push_back(vector<string>() );
      energy_list.push_back(vector<double>() );
      rfile_name = rfile_name_backup;
      policy = policy_list[j];
      for(unsigned int k = 0 ; k < critical_list[i].size() ; ++k){
        stringstream ss;
        ss << critical_list[i][k];
        string str = "";
        if(k < critical_list[i].size()-1){
          str = ss.str() + "_";
          task_name+=str;
        }
        else{
          str = ss.str();
          task_name+=str;
        }
        rfile_name += str;
      }
      combine_name = rfile_name + "/combine.csv";
      string r_policy_name = rfile_name + "/" + policy + ".log";
      // cout << r_policy_name << endl;
      w_policy_file.open(r_policy_name.c_str(), ios::in);//open 
      if(w_policy_file.is_open()){
        string token = "";
        string line = "";
        while(getline(w_policy_file, line, '\n')){
          token = parse_line(line);
          //cout << token << endl;
          lifetime_string_list.back().push_back(token);//ex. 1y
          token = parse_line(line);
          //cout << token << endl;
          lifetime_list.back().push_back( atof(token.c_str()) );//ex. 31,536,000s
          token = parse_line(line);
          //cout << atof(token.c_str()) << endl;
          energy_list.back().push_back( atof(token.c_str()) ); //ex. 100wt
        }
      }
      w_policy_file.close();     
    }
    //cout << energy_list[1][0] << endl;

    combineFile.open(combine_name.c_str(), ios::out);
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      combineFile << policy_list[j] << ",";
    }
    combineFile << endl;

    for(unsigned int j = 0 ; j < lifetime_list.size(); ++j ){
      combineFile << lifetime_list[j].back() << ",";
      combine.lifetime_list.back().back().push_back(lifetime_list[j].back());
    }
    for(unsigned int j = 0 ; j < lifetime_list.size() ; ++j){
      combineFile << lifetime_list[j].back() / lifetime_list.front().back() << ",";
      combine.normalized_lifetime_list.back().back().push_back(lifetime_list[j].back() / lifetime_list.front().back() );
    }
    combineFile << endl;  

    unsigned int index  = min_lifetime_size_index(lifetime_string_list);
    //unsigned int index = 0;
    for(unsigned int j = 0 ; j < lifetime_list.size(); ++j){
      //cout << j << "," << index << endl;
      //cout << energy_list[j][index] << endl;
      combineFile << energy_list[j][index] <<",";
      combine.energy_list.back().back().push_back(energy_list[j][index] );
    }
    for(unsigned int j = 0 ; j < lifetime_list.size(); ++j){
      combineFile <<  energy_list[j][index] / energy_list[0][index] <<",";
      combine.normalized_energy_list.back().back().push_back(energy_list[j][index] / energy_list[0][index] );
    }
    combineFile << endl;
    combineFile.close();
    combine.task_list.back().push_back(task_name);
  }

  for(unsigned int i = 0 ; i < averge_lifetime_list.size() ; ++i){// 2, 4, 6
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      averge_lifetime_list[i].push_back(0.0);
      averge_normal_lifetime_list[i].push_back(0.0);
      geomean_normal_lifetime_list[i].push_back(1);
      averge_energy_list[i].push_back(0.0);
      averge_normal_energy_list[i].push_back(0.0);
      geomean_normal_energy_list[i].push_back(1);
    }  
  }
  
  for(unsigned int i = 0 ; i < combine.lifetime_list.size() ; ++i){// 2, 4, 6
    stringstream ss;
    ss << (2*i+2);
    string str = "";
    str = ss.str();
    string total_lifetime_file_name = benchmark_name + "_lifetime_" + str + ".csv";
    string total_energy_file_name = benchmark_name + "_energy_" + str + ".csv";
    totalLifetimeFile.open(total_lifetime_file_name.c_str(), ios::out);
    totalEnergyFile.open(total_energy_file_name.c_str(), ios::out);
    totalLifetimeFile << ",";
    totalEnergyFile <<",";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      totalLifetimeFile << policy_list[j] << ",";
      totalEnergyFile << policy_list[j] << ",";
    }
    totalLifetimeFile << endl;
    totalEnergyFile <<endl;
    for(unsigned int j = 0 ; j < combine.lifetime_list[i].size() ; ++j){//Task1_2....
      totalLifetimeFile << combine.task_list[i][j] << ",";
      totalEnergyFile << combine.task_list[i][j] << ",";
      for(unsigned int k = 0 ; k < combine.normalized_lifetime_list[i][j].size() ; ++k){//policy
        totalLifetimeFile << combine.normalized_lifetime_list[i][j][k] << ",";
        totalEnergyFile << combine.normalized_energy_list[i][j][k] << ",";
        averge_normal_lifetime_list[i][k] += combine.normalized_lifetime_list[i][j][k];
        geomean_normal_lifetime_list[i][k] = geomean_normal_lifetime_list[i][k] * combine.normalized_lifetime_list[i][j][k];
        averge_normal_energy_list[i][k] += combine.normalized_energy_list[i][j][k];
        geomean_normal_energy_list[i][k] = geomean_normal_energy_list[i][k] * combine.normalized_energy_list[i][j][k];
      }
      totalLifetimeFile << ",";
      totalEnergyFile  << ",";      
      for(unsigned int k = 0 ; k < combine.lifetime_list[i][j].size() ; ++k){//policy
        totalLifetimeFile << combine.lifetime_list[i][j][k] << ",";
        totalEnergyFile << combine.energy_list[i][j][k] << ",";
        averge_lifetime_list[i][k] += combine.lifetime_list[i][j][k];
        averge_energy_list[i][k] += combine.energy_list[i][j][k];
      }
      totalLifetimeFile << endl;
      totalEnergyFile << endl;
    }
    totalLifetimeFile << endl;
    totalEnergyFile << endl;
    double num_case = combine.lifetime_list[i].size() ;
    totalLifetimeFile << ",";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      //totalLifetimeFile << averge_normal_lifetime_list[i][j] / num_case<< ",";   
      totalLifetimeFile << pow(geomean_normal_lifetime_list[i][j], 1.0/num_case) << ",";
    }
    totalLifetimeFile << ",,";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      totalLifetimeFile << averge_lifetime_list[i][j] / 31536000.0 / num_case<< ",";   
    }
    totalEnergyFile << ",";
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      //totalEnergyFile << averge_normal_energy_list[i][j] / num_case<< ",";
      totalEnergyFile << pow(geomean_normal_energy_list[i][j], 1.0/num_case) << ",";
    }
    totalEnergyFile << ",,";
     
    for(unsigned int j = 0 ; j < policy_list.size() ; ++j){
      totalEnergyFile << averge_energy_list[i][j] /  num_case<< ",";  
    }    
    totalLifetimeFile.close();
    totalEnergyFile.close();
  }

}
