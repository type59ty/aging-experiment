#include "read_mt.h"
#define NUM_IV 8
#define NS 1000000000
#define Frequency 100
ReadMT::~ReadMT(){
  file.close();
}
double ReadMT::computeDelay(int Frequency_int, int Num_Iv){
  stringstream ss;
  double Max_delay = 0.0;
  //double Total = 0.0;
  //vector<double> total_tmp;
  //number of input vector
  for(unsigned int i = 1 ; i < (unsigned int) Num_Iv ; ++i){
    //cout << "\n" << i << endl;
    //cout << "================="<< endl;
    vector<double> input_tmp;
    vector<double> output_tmp;
    //double output_delay = 0.0;
    for(unsigned int j = 0 ; j < input_port.size() ; ++j){
      ss << i;
      string int2str = ss.str();
      string port_name = input_port[j];
      string key = port_name + "_stable_" + int2str;
      //cout << key << endl;      
      input_tmp.push_back(getValue(key));
      //cout << getValue(key) << "\n" << endl;      
      ss.str("");
      ss.clear();
    }
    double input_delay = *min_element(input_tmp.begin(), input_tmp.end());
    if(input_delay == 0.0){
      input_delay = (i) * ((double) Frequency_int) * 0.000000001;
    }
    //cout << "\nMin input: " << input_delay * NS<< "\n" << endl;     
    for(unsigned int j = 0 ; j < output_port.size() ; ++j){
      ss << i;
      string int2str = ss.str();
      string port_name = output_port[j];
      string key = port_name + "_stable_" + int2str;
      //cout << key << endl;
      //double out_tmp = getValue(key);
      /*if(out_tmp > 0.0){
        output_tmp.push_back(out_tmp);
        output_delay += out_tmp;
      }  */    
      output_tmp.push_back(getValue(key));
      //cout << getValue(key) * 1000000000 << "\n" << endl;      
      ss.str("");
      ss.clear();
    } 
    double output_delay = *max_element(output_tmp.begin(), output_tmp.end());
    /*if(output_tmp.size() != 0){
      //throw runtime_error("output_tmp.size() == 0");
      output_delay = output_delay / (double)output_tmp.size();
     
    }else{
      output_delay = 0.0;
    }*/
    
    /*if(output_delay == 0.0){
      output_delay = (i) * Frequency * 0.000000001;
    }*/
    //cout << "\nMax output: " << output_delay * NS<< "\n" << endl; 
    double total_delay = output_delay - input_delay;
    /*if(total_delay > 0.0){
      //cout << total_delay * NS << endl;
      total_tmp.push_back(total_delay);
      Total += total_delay;
    }*/
    //cout << "\nDiff output: " << total_delay << "\n" << endl; 
    if(total_delay > Max_delay)
      Max_delay = total_delay;
    //cout << "\nTotal: " << total_delay << "\n" << endl; 
  }
  //Total = Total / (double)total_tmp.size();
  //cout << "\nMax delay: " << Max_delay * NS << "\n" << endl; 
  return Max_delay;
  //return Total;
};
ReadMT::ReadMT(string file_name, vector<string> input_port, vector<string> output_port){
  ParseMT(file_name);
  this->input_port = input_port;
  this->output_port = output_port;
}
double ReadMT::getValue(string key){
  map<string, double>::iterator it;
  it = MTmap.find(key);
  if(it != MTmap.end()){
    return it->second;
  }
  else{
    cout << key << endl;
    throw runtime_error("key can't find");
    return 0;
  }
}
string ReadMT::Parseline(string &line){
  std::string token("");
  std::string::size_type  index = 0;
  while(line.size() > 0){
    if((line[index] >= '0'  && line[index] <= '9')  || 
       (line[index] >= 'A'  && line[index] <= 'Z')  || 
       (line[index] >= 'a'  && line[index] <= 'z')  ||
       (line[index] == '_') || (line[index] == '.') ||
       (line[index] == '-') || (line[index] == '#') ){
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

void ReadMT::ParseMT(string file_name){
  bool value_mode = false;
  unsigned int index = 0;
  file.open(file_name.c_str(), ios::in);
  if(!file){
    //cout<<"Fail to open file: "<< file_name <<endl;
    throw runtime_error("Fail to open file:" + file_name);
  }
  string line("");
  getline(file, line, '\n');
  getline(file, line, '\n');
  while(getline(file, line, '\n')){
    while(line != ""){
      string token = Parseline(line);
      if(!value_mode){//name_mode
        if(token == "alter#"){
          value_mode = true;
        }
        if(token != ""){
          MT mt;
          mt.name = token;
          mt.value = 0;
          MTs.push_back(mt);
        }       
      }
      else{//value_mode
        if(token != ""){
          if(token == "failed"){
            token = "0";
          }
          MTs[index].value = atof(token.c_str());
          MTmap.insert( pair<string, double>(MTs[index].name, MTs[index].value) );
          index++;
        }
      }     
    }
  }
}