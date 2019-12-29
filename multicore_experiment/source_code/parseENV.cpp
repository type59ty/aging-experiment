#include "parseENV.h"
ENV::ENV(){
  
}
vector<vector<unsigned int> > ENV::get_critical_list(){
  return critical_list;
}
double ENV::get_critical_ratio(){
  return critical_ratio;
}
double ENV::get_nonCritical_ratio(){
  return nonCritical_ratio;
}
string ENV::parse_line(string &line){
  string token("");
  string::size_type  index = 0;
  while(line.size() > 0){
    if((line[index] >= '0'  && line[index] <= '9') || 
       (line[index] == '.') ||
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
void ENV::start_parse(char *file_name){
  ifstream file(file_name, ios::in);
  string line("");
  getline(file, line, '\n');
  getline(file, line, '\n');
  critical_ratio = atof(line.c_str());
  //cout << critical_ratio << endl;
  getline(file, line, '\n');
  getline(file, line, '\n');  
  nonCritical_ratio = atof(line.c_str());
  //cout << nonCritical_ratio << endl;
  while(getline(file, line, '\n')){
    if(line[0] != '#'){
      while(!line.empty()){
        string token = parse_line(line);
        if(token == "round"){
          critical_list.push_back(vector<unsigned int>() );
          getline(file, line, '\n');
          getline(file, line, '\n');
          while(!line.empty()){
            token = parse_line(line);
            critical_list.back().push_back( (unsigned int)(atoi(token.c_str())));            
          }
        }
      }         
    }
  }
  /*for(unsigned int i = 0 ; i < critical_list.size() ; ++i){
    for(unsigned int j = 0 ; j < critical_list[i].size() ; ++j){
      cout << critical_list[i][j] << ", "; 
    }
    cout << endl;    
  }*/
}