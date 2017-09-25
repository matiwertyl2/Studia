#include <iostream>
#include <cmath>
#include <vector>

struct surf
{
  virtual double area( ) const = 0;
  virtual double circumference( ) const = 0;
  virtual surf* clone( ) const & = 0;
  virtual surf* clone( ) && = 0;
  virtual void print( std::ostream& out) const = 0;
  virtual ~surf( ) {}
};

struct rectangle : public surf
{
  double x1, y1;
  double x2, y2;
  rectangle (double x1, double y1, double x2, double y2)
    : x1{x1}, x2{x2}, y1{y1}, y2{y2}
  {}
  double area( ) const override {
    return (x1-x2)*(y1-y2);
  }
  double circumference( ) const override {
    return abs(x1-x2)*2+abs(y1-y2)*2;
  }
  rectangle* clone( ) const & override {
    return new rectangle (x1, y1, x2, y2);
  }
  rectangle* clone( ) && override {
    return new rectangle {std::move(*this)};
  }
  void print( std::ostream& out) const override {
    out << "RECTANGLE " << x1 << " " << y1 << " " << x2 << " " << y2;
  }
};

struct triangle : public surf
{
  double x1, y1; // Positions of corners.
  double x2, y2;
  double x3, y3;
  triangle (double x1, double y1, double x2, double y2, double x3, double y3)
    : x1{x1}, y1{y1}, x2{x2}, y2{y2}, x3{x3}, y3{y3}
  {}

  double area( ) const override {
    return ((x1-x3)*(y2-y3) - (x2-x3)*(y1-y3))/2;
  }

  double len (double a1, double b1, double a2, double b2) const {
    return sqrt ((a1-a2)*(a1-a2)+(b1-b2)*(b1-b2));
  }
  double circumference( ) const override {
    double d1= len (x1, y1, x2, y2);
    double d2 = len (x1, y1, x3, y3);
    double d3= len (x2, y2, x3, y3);
    return d1+d2+d3;
  }
  triangle* clone( ) const & override {
    return new triangle (x1, y1, x2, y2, x3, y3);
  }
  triangle* clone( ) && override {
    return new triangle {std::move(*this)};
  }
  void print( std::ostream& out ) const override {
    out << "TRIANGLE " << x1 << " " << y1 << " " << x2 << " " << y2 << " " << x3 << " " << y3;
  }
};

struct circle : public surf
{
  double x; // Position of center.
  double y;
  double radius;
  circle (double x, double y, double r)
    : x{x}, y{y}, radius{r}
  {}
  double area( ) const override {
    return M_PI*radius*radius;
  }
  double circumference( ) const override {
    return 2*M_PI*radius;
  }
  circle* clone( ) const & override {
    return new circle (x, y, radius);
  }
  circle* clone( ) && override {
    return new circle{std::move(*this)};
  }
  void print( std::ostream& out) const override {
    out << "CIRCLE " << x << " " << y << " " << radius;
  }
};

struct surface
{
  surf* ref;
  surface( const surface& s )
    :ref{ s.ref->clone()}
  {}
  surface( surface&& s )
    :ref { std::move(*s.ref).clone()}
  {}
  surface( const surf& s )
    : ref{s.clone()}
  {}
  surface( surf&& s )
    : ref{s.clone()}
  {}
  void operator = ( const surface& s ) {
    *this= surface(s);
  }
  void operator = ( surface&& s ) {
    std::swap(ref, s.ref);
  }
  void operator = ( const surf& s ) {
    ref= s.clone();
  }
  void operator = ( surf&& s ) {
    ref=s.clone();
  }
  ~surface( )
  {
  delete ref;
  }
  const surf& getsurf( ) const { return *ref; }
  // There is no non-const access, because
  // changing would be dangerous.
};

std::ostream& operator << ( std::ostream& stream, const surface& s ) {
  s.ref->print(stream);
  return stream;
}

std::ostream& operator << ( std::ostream& stream, const std::vector< surface > & table )
{
  for( size_t i = 0; i < table. size( ); ++ i )
  {
    stream << i << "-th element = " << table [i] << "\n";
  }
  return stream;
}

void print_statistics( const std::vector< surface > & table )
{
  double total_area = 0.0;
  double total_circumference = 0.0;
  for( const auto& s : table )
  {
    std::cout << "adding info about " << s << "\n";
    total_area += s. getsurf( ). area( );
    total_circumference += s. getsurf( ). circumference( );
  }
  std::cout << "total area is " << total_area << "\n";
  std::cout << "total circumference is " << total_circumference << "\n";
}



int main () {
  rectangle r (0.0, 0.0, 1.0, 1.0);
  triangle t2 (0, 0, 3, 0, 0, 4);
  circle c (1, 1, 2);
  std::vector<surface> v ={r, t2, c};
  std::cout << v << "\n";
  print_statistics(v);
  std::cout << "\n";
}
