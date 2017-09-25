#include <bits/stdc++.h>

struct case_insensitive_cmp {
  bool operator( ) ( const std::string& s1, const std::string& s2 ) const {
      for (size_t i=0; i<s1.size(); i++) {
        if (i==s2.size()) return false;
        char c1, c2;
        c1= toupper(s1[i]);
        c2=toupper(s2[i]);
        if (c1<c2) return true;
        if (c1>c2) return false;
      }
      if (s1.size()<s2.size()) return true;
      return false;
  }
};

std::map< std::string, unsigned int, case_insensitive_cmp > frequencytable(const std::vector< std::string > & text ) {
  std::map<std::string , unsigned int, case_insensitive_cmp> M;
  for (auto s : text) M[s]++;
  return M;
}

std::ostream &operator << ( std::ostream& stream, const std::map< std::string, unsigned int, case_insensitive_cmp > & freq ) {
  for (auto d : freq) {
    stream << d.first << " " << d.second << "\n";
  }
  return stream;
}

struct case_insensitive_hash {
  size_t operator ( ) ( const std::string& s ) const {
    size_t h=0;
    size_t p=171;
    size_t p0=171;
    size_t mod= 1234567891;
    for (size_t i=0; i<s.size(); i++) {
      h=(toupper(s[i])*p) % mod;
      p= (p*p0) % mod;
    }
    return h;
  }
};

struct case_insensitive_equality
{
  bool operator ( ) ( const std::string& s1, const std::string& s2 ) const {
    if (s1.size()!=s2.size()) return false;
    for (size_t i=0; i<s1.size(); i++) {
      if (toupper(s1[i])!=toupper(s2[i])) return false;
    }
    return true;
  }
};

std::unordered_map< std::string, unsigned int, case_insensitive_hash, case_insensitive_equality >  hashed_frequencytable( const std::vector< std::string > &text ) {
  std::unordered_map<std::string , unsigned int, case_insensitive_hash, case_insensitive_equality> M;
  for (auto s : text) M[s]++;
  return M;
}

std::ostream &operator << ( std::ostream& stream, const std::unordered_map< std::string, unsigned int, case_insensitive_hash, case_insensitive_equality > & freq ) {
  for (auto d : freq) {
    stream << d.first << " " << d.second << "\n";
  }
  return stream;
}


std::vector<std::string> readfile( std::istream& input )
{
  std::vector<std::string> V;
  std::string S="";
  while (input.good()) {
    char c= (char)input.get();
    if (isspace(c) || ispunct(c)) {
      if (S.size()>0) V.push_back(S);
      S.clear();
    }
    else S+=c;
  }
  return V;
}

std::string most_frequent (std::unordered_map< std::string, unsigned int, case_insensitive_hash, case_insensitive_equality > & Book) {
  std::string s;
  unsigned int  x=0;
  for (auto d : Book) {
    if (d.second>x) {
      x=d.second;
      s=d.first;
    }
  }
  return s;
}

int main () {
  std::cout << hashed_frequencytable( std::vector< std::string >{ "AA", "aA", "Aa", "this", "THIS" } );
  std::cout << frequencytable( std::vector< std::string >{ "AA", "aA", "Aa", "this", "THIS" } );
  case_insensitive_cmp c;
  std::cout << c( "a", "A" ) << c( "a","b" ) << c( "A", "b" ) << "\n";
  case_insensitive_hash h;
  std::cout << h( "xxx" ) << " " << h( "XXX" ) << "\n";
  std::cout << h( "Abc" ) << " " << h( "abC" ) << "\n";
  case_insensitive_equality e;
  std::cout << e( "xxx", "XXX" ) << "\n";
  std::vector< std::string > book;
  std::ifstream input_book{"book.txt"};
  book= readfile(input_book);
  std::unordered_map< std::string, unsigned int, case_insensitive_hash, case_insensitive_equality > Book= hashed_frequencytable(book);
  std::cout << "magnus " << Book["Magnus"] << "\n";
  std::cout << "hominum " << Book["hominum"] << "\n";
  std::cout << "memoria " << Book["memoria"] << "\n";
  std::cout << "most frequent " << most_frequent(Book) << " " << Book[most_frequent(Book)] << "\n";

}
