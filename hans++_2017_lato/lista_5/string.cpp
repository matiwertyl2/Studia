
#include "string.h"
#include <stdexcept>

char string::operator [] (size_t i) const {
  if (i<len && i>=0) {
    return p[i];
  }
  else throw std::runtime_error("runtime error");
}

char& string::operator [] (size_t i) {
  if (i<len && i>=0) {
    return p[i];
  }
  else throw std::runtime_error("runtime error");
}

void string::operator += (char c) {
  char * pnew= new char[len+1];
  for (size_t i=0; i<len; i++) {
    pnew[i]=p[i];
  }
  pnew[len]=c;
  delete[] p;
  p=pnew;
  len++;
}

void string::operator += (const string& s) {
  char * pnew = new char[len+s.len];
  for (size_t i=0; i<len; i++) pnew[i]=p[i];
  for (size_t i=0; i<s.len; i++) pnew[i+len]=s.p[i];
  len+=s.len;
  delete[] p;
  p=pnew;
}

string operator + (const string& s1, const string& s2) {
  string res= s1;
  res+=s2;
  return res;
}

bool operator == ( const string& s1, const string& s2 ) {
  if (s1.len!=s2.len) return false;
  for (size_t i=0; i<s1.len; i++) {
    if (s1.p[i]!=s2.p[i]) return false;
  }
  return true;
}

bool operator != ( const string& s1, const string& s2 ) {
  if (s1==s2) return false;
  return true;
}

bool operator < ( const string& s1, const string& s2 )  {
  for (size_t i=0; i<std::min(s1.len, s2.len); i++) {
    if (s1.p[i]<s2.p[i]) return true;
    if (s1.p[i]>s2.p[i]) return false;
  }
  if (s1.len<s2.len) return true;
  return false;
}

bool operator > ( const string& s1, const string& s2 ) {
  if (s2 < s1) return true;
  return false;
}

bool operator <= ( const string& s1, const string& s2 )  {
  if (s1 < s2) return true;
  if (s1 == s2) return true;
  return false;
}

bool operator >= ( const string& s1, const string& s2 )  {
  if (s1 > s2) return true;
  if (s1 == s2) return true;
  return false;
}

std::ostream& operator << ( std::ostream& out, const string& s )
{
   for (const char& c : s) out << c;
   return out;
}
