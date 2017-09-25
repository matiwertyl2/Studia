#include <iostream>
#include <initializer_list>
#include "stack.h"
#include <stdexcept>

void stack::ensure_capacity( size_t c )
{
  if( current_capacity < c )
  {
    // New capacity will be the greater of c and
    // 2 * current_capacity.
    if( c < 2 * current_capacity )  c = 2 * current_capacity;
    double* newtab = new double[ c ];
    for( size_t i = 0; i < current_size; ++ i )  newtab[i] = tab[i];
    current_capacity = c;
    delete[] tab;
    tab = newtab;
  }
}

stack::stack()
  : current_size{0}, current_capacity{0}, tab{new double[0]}
{}

stack::stack( std::initializer_list<double> d )
  : current_size{d.size()}, current_capacity{d.size()}, tab{new double[d.size()]}
{
  size_t i=0;
  for (auto x : d) {
    tab[i]=x;
    i++;
  }
}


stack::stack(const stack& s)
  : current_size{s.current_size}, current_capacity{s.current_capacity},
    tab{new double[s.current_capacity]}
{
  for (size_t i=0; i<current_size; i++) tab[i]=s.tab[i];
}
// So that you can write s = { 1,2,3 };
// You need d. size( ) and for( double d : s ) .....
stack::~stack() {
  delete[] tab;
}

void stack::operator = ( const stack& s ) {
  ensure_capacity(s.current_capacity);
  current_size=s.current_size;
  for (size_t i=0; i<current_size; i++) {
    tab[i]=s.tab[i];
  }
}

void stack::push( double d ) {
  ensure_capacity(current_capacity+1);
  tab[current_size]=d;
  current_size++;
}

void stack::pop( ) {
  if (current_size!=0) {
    current_size--;
  }
  else {
    throw std::runtime_error("pop from empty stack");
  }
}

void stack::reset( size_t s ){
  if (s<=current_size) {
    while (current_size>s) pop();
  }
  else {
    throw std::runtime_error("runtime error");
  }
}

double& stack::top( ) {
  return tab[current_size-1];
}

double stack::top( ) const {
  return tab[current_size-1];
}

std::ostream& operator << ( std::ostream& stream, const stack& s ) {
  for (size_t i=0; i<s.size(); i++) {
    stream << s.tab[i] << " ";
  }
  return stream;
}
