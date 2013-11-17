//
//  main.cpp
//  QuestionParser
//
//  Created by Timothy Dooris on 11/16/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#include <iostream>
using std::cout;
using std::endl;

#include <fstream>
using std::ifstream;

#include <cstring>


using namespace std;
int counter = 0;
// 0 = throwaway
//1 = question
//2 = ans1
//3 = ans2
//4 = ans3
//5 = ans 4
//6 = explanation
//reset


struct buffer{
    string category;
    string question;
    string ans1;
    string ans2;
    string ans3;
    string ans4;
    string answer;
    string explanation;
} buf;

int main()
{
    ofstream output;
    output.open("/Users/tdooris/Desktop/iOS/QuestionParser/globalconnectionsQuestions.txt");
    
    std::ifstream input("/Users/tdooris/Desktop/iOS/QuestionParser/data8.txt");
    std::string line;
    
    while( std::getline( input, line ) ) {
        //std::cout<<line<<'\n';
        if(!line.empty()){
            if(line != "More Information"){
                switch(counter){
                    case 0:
                        output<<"<dict><key>category</key><string>globalconnections</string>"<<endl;
                        break;
                    case 1:
                        output << "<key>question</key>"<<endl;
                        output<<"<string>"<<line<<"</string>"<<endl;
                        break;
                        
                    case 2:
                        output << "<key>ans1</key>"<<endl;
                        output<<"<string>"<<line<<"</string>"<<endl;
                        break;
                    case 3:
                        output << "<key>ans2</key>"<<endl;
                        output<<"<string>"<<line<<"</string>"<<endl;
                        break;
                    case 4:
                        output << "<key>ans3</key>"<<endl;
                        output<<"<string>"<<line<<"</string>"<<endl;
                        break;
                    case 5:
                        output << "<key>ans4</key>"<<endl;
                        output<<"<string>"<<line<<"</string>"<<endl;
                        break;
                    case 6:
                        output<<"<key>answer</key>"<<endl;  //need to get just the number from "correct answer number: 1"
                        output<<"<string>";
                        output<<line[23];
                        output<<"</string>"<<endl;
                        break;
                    case 7:
                        output << "<key>explanation</key>"<<endl;
                        output<<"<string>"<<line<<"</string>"<<endl;
                        output<<"</dict>"<<endl;
                        break;
                    default:
                        //What's the default?
                        break;
                }
                if(counter < 7)
                    counter++;
                else
                    counter = 0;
                
            }
        
            
            
        
    

        
        }

    }


    return 0;
}

