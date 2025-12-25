// - Author: Jorge_Slime - 25.12.2025 | 14:22:51
#include <bits/stdc++.h>
#include <vector>
using namespace std; 
#define forn(i,a,b) \
    using _T = decay_t<decltype(b)>; \
    for (_T i = (a); i < (b); ++i)
#define all(x) (x).begin(),(x).end()
#define sz(x) int((x).size())
#if defined(SLIME)
    #include "/home/jorge/slime_debug.hpp"   
#else                                        
    #define _(...) void(77)
#endif
using i64 = int64_t;         

auto solve([[maybe_unused]]auto&& tc)->void{ 
    int n; cin >> n; 
    vector<int> ar(n); 
    forn(i, 0, n) cout << ar[i] <<" \n"[i == n - 1];
    forn(i, 0, n){

    }
};
[[gnu::target("avx2")]] auto main(void) -> int {
    cin.tie(nullptr)->sync_with_stdio(false);
    cin.exceptions(ios::failbit | ios::badbit);
    size_t t_c = 1;
    cin >> t_c;
    forn(t,0,t_c){ _(case(t)); solve(t); }
    _(time_());
    return 0;
} // I can....

