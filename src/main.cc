#include <unordered_map>
#include <string>
#include <cstdlib> //rand
#include <random>

static const std::string all_options = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
static const std::default_random_engine generator;

void
finialize_values_for_testing(
  std::unordered_map< char, int > & current_values
){
  current_values[ Z ] = current_values[ X ] * current_values[ Y ];
}

void
initialize_values(
  std::unordered_map< char, int > & current_values
){
  current_values[ A ] = 1;
  current_values[ B ] = 1;
  current_values[ C ] = 1000;
  current_values[ D ] = 100;
  current_values[ E ] = 10;
  current_values[ F ] = 100;
  current_values[ G ] = 10;
  current_values[ H ] = 100;
  current_values[ I ] = 10;
  current_values[ J ] = 100;
  current_values[ K ] = 10;
  current_values[ L ] = 100;
  current_values[ M ] = 10;
  current_values[ N ] = 100;
  current_values[ O ] = 10;
  current_values[ P ] = 100;
  current_values[ Q ] = 10;
  current_values[ R ] = 100;
  current_values[ S ] = 10;
  current_values[ T ] = 100;
  current_values[ U ] = 10;
  current_values[ V ] = 100;
  current_values[ W ] = 10;
  current_values[ X ] = 100;
  current_values[ Y ] = 10;
  current_values[ Z ] = 1000;

  finialize_values_for_testing( current_values );
}

void
randomly_perturb_values(
  std::unordered_map< char, int > & current_values
){
  //TODO will values of 1 ever increase?

  for( int i = 0; i < all_options.size(); ++i ){
    char const key = all_options[ i ];
    double const mean = current_values[ key ];

    //stddev is 0-16%
    int const rand_between_0_and_10 = rand() % 16;
    double const random_percentage = double( rand_between_0_and_10 ) / 100;
    double const stddev = mean * random_percentage;

    std::normal_distribution< double > distribution( mean, stddev );
    double const random_number = distribution(generator);
    int setting = int( random_number );
    if( setting < 1 ) setting = 1;

    current_values[ key ] = setting;
  }
}

void main(){
  std::unordered_map< char, int > current_values;
  initialize_values( current_values );
}
