import 'dart:io';

void main(){
  print("Hello Developers");
  // stdout.write("Enter Your Name: ");
  // var name = stdin.readLineSync();
  // stdout.write("Hello $name");
  // stdout.
  var list1 = [10,20,30,40,50];
  // list1.clear();
  // for(var i=0; i<list1.length; i++){
  //  stdout.write(i);
  // }
  stdout.write(list1);
  if(list1.length>1){

  }
  var human = LivingBeing();
}

class LivingBeing{

}

class Human extends LivingBeing{
  void check(){
    bool isHuman = true;
    if(isHuman){
      stdout.write("This is Human");
    }
  }
  // stdin.readLineSync()



}