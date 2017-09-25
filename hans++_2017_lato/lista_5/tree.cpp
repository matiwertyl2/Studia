
#include "tree.h"



tree::tree( const tree& t )
  : pntr{t.pntr}
{
  t.pntr->refcnt++;
}

tree::~tree() {
  pntr->refcnt--;
  if(pntr->refcnt==0) delete pntr;
}

void tree::operator = (tree&& t)
{
    auto x = t.pntr;
    t.pntr = pntr;
    pntr = x;
}

void tree::operator = (const tree& t)
{
    *this = tree(t);
}

const string& tree::functor( ) const {
  return pntr->f;
}

const tree& tree::operator [ ] ( size_t i ) const {
  return pntr->subtrees[i];
}

size_t tree::nrsubtrees( ) const {
  return pntr->subtrees.size();
}

void tree::ensure_not_shared( ) {
  if (pntr->refcnt>1) {
    pntr->refcnt--;
    pntr= new trnode(pntr->f, pntr->subtrees, 1);
  }
}

string& tree::functor( ) {
  ensure_not_shared();
  return pntr->f;
}

tree& tree::operator [ ] ( size_t i ) {
  ensure_not_shared();
  return pntr->subtrees[i];
}

void tree::replacesubtree(size_t i, const tree& t) {
  if (pntr->subtrees[i].pntr!=t.pntr) {
    ensure_not_shared();
    pntr->subtrees[i]=t;
  }
}

void tree::replacefunctor(const string& f) {
  if (pntr->f !=f) {
    ensure_not_shared();
    pntr->f=f;
  }
}

tree subst_new(const tree& t, const string& var, const tree& val) {
  if (t.nrsubtrees()==0) {
    if (t.functor()==var) return tree(val);
    return t;
  }
  tree T= tree(t);
  for (size_t i=0; i<t.nrsubtrees(); i++) {
    T.replacesubtree(i, subst_new(t[i], var, val));
  }
  return T;
}


tree subst( const tree& t, const string& var, const tree& val ) {
  if (t.nrsubtrees()==0) {
    if (t.functor()==var) return tree(val);
    return t;
  }
  std::vector<tree> subtrees;
  for (size_t i=0; i<t.nrsubtrees(); i++) {
    subtrees.push_back(subst(t[i], var, val));
  }
  return tree(t.functor(), subtrees);
}


std::ostream& operator << ( std::ostream& stream , const tree& t){
  stream << t.functor();
  if (t.nrsubtrees()==0) return stream;
  stream << "(";
  for (size_t i=0; i<t.nrsubtrees(); i++) {
    stream << t[i];
    if (i!=t.nrsubtrees()-1) stream << ", ";
  }
  stream << ")";
  return stream;
}
