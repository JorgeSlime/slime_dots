// - Author: Jorge_Slime - 25.05.2025 | 18:11:04
#include <bits/stdc++.h>
#define sz(x)  (int)x.size()
#define forn(i,a,b) for(auto i{a};i<b;++i)
#if defined(SLIME)
    #include "/home/jorge/slime_debug.hpp"
#else
    #define _(...) void(77)
#endif
using i64 = int64_t;
//Bits utils
inline namespace UTIL_BITS{
#define TEM template<typename T> inline 
#define st32(x) static_cast<uint32_t>(x) 
#define st64(x) static_cast<uint64_t>(x) 
//te dice el el numero de bits encedidos espedico 3 = 111 -> 7
TEM int pop_count(const T& x) {return (sizeof(T)<=4)?__builtin_popcount(st32(x)):__builtin_popcountll(st64(x));}
// si el total de bits activos es impar o par 
TEM int pop_parity(const T& x) {return (sizeof(T)<=4)?__builtin_parity(st32(x)):__builtin_parityll(st64(x));}
// pos de bit activo mas alto [0,1,2,3,4,5]->[-1,0,1,1,2] 
TEM int topbit(const T& x) {return (x==0)?-1:(sizeof(T)<=4)?31-__builtin_clz(st32(x)):63-__builtin_clzll(st64(x));}
// pos de bit activo mas bajo [0,1,2,3,4]->[-1,31,30,30,29]
TEM int lowbit(const T& x) {return (x==0)?-1:(sizeof(T)<=4)?__builtin_ctz(st32(x)):__builtin_ctzll(st64(x));}
//te dice si es potencia de dos
TEM bool ispow2(const T& i){return i&&(i&-i)==i;}
//calcula la potecia de dos mayor o igual a  n 
TEM T minpot2(const T& n){return T(1)<<(topbit(n-1)+1);}
//Apaga (pone en 0) el bit en la pos p 
TEM T off_bit(T& n, int p) {return n & ~(T(1) << p);}
//Enciende (pone en 1) el bit en la pos p 
TEM T on_bit(T n, int p) {return n | (T(1)<< p);}
//invierte el estado del bit en la pos p 
TEM T change_bit(T n, int p) {return n ^ (T(1)<< p);}
//retorna el valor del bit en la pos p 
TEM bool has_pos_bit(T& n, int p){return n >> p & T(1);}
//retorna el valor total del bit mas peque 18 = 10010 -> 10 = 2
TEM T lowest_bit(const T& n) {return n & -n;}
// retorna el rango dado con bits activos
TEM T create_mask(int l, int r){return ((1U<<(r-l+1))-1)<< l;}
// cuenta bits activos entre l y r (inclusive)
TEM int bit_count_range(T x, int l, int r){ 
    return pop_count((x >> l) & ((T(1) << (r - l + 1)) - 1)); 
}
// cantidad de bits necesarios para representar x (topbit + 1)
TEM int bit_length(const T& x){ return x == 0 ? 0 : topbit(x) + 1;}
// suma total de bits activos en [0..n] (O(log n))
TEM T pref_bit(T n){ // in log2(n)
    T res = 0;
    for(int i = 0; (T(1) << i) <= n; ++i){
        T total = (n + 1) / (T(1) << (i + 1));
        res += total * (T(1) << i);
        T rem = (n + 1) % (T(1) << (i + 1));
        if(rem > (T(1) << i)) res += rem - (T(1) << i);
    }
    return res;
}
// suma de bits activos en [l..r]
TEM T range_bit(T l, T r){ return pref_bit(r) - pref_bit(l - 1); }
// suma de bits usados (bit_length) en [l..r] in log2(n)
TEM T total_bits(T l, T r){
    T total = 0;
    for(int i = 0; i < 8 * sizeof(T); ++i){
        T lo = std::max<T>(l, T(1) << i);
        T hi = std::min<T>(r, (T(1) << (i + 1)) - 1);
        if(lo > hi) continue;
        total += (hi - lo + 1) * (i + 1);
    }
    return total;
}
#undef sp32 
#undef sp64 
#undef TEM
}
[[gnu::target("avx2")]] auto main(void) -> int {
    std::cin.tie(nullptr)->sync_with_stdio(false);
    std::cin.exceptions(std::ios::failbit | std::ios::badbit);

    i64 n; std::cin >> n; 
    std::cout << pref_bit(n) << '\n'; 

    _(time()); return 0;
} // I can....
