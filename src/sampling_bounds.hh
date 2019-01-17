//from https://stackoverflow.com/questions/26351587/how-to-create-stdarray-with-initialization-list-without-providing-size-directl
template <typename V, typename... T>
constexpr auto array_of(T&&... t) -> std::array < V, sizeof...(T) >
{
    return {{ std::forward<T>(t)... }};
}

//all are std::arrays
constexpr auto vals_for_C = array_of< int >( 250, 500, 1000, 2000, 5000 );//num initial nstruct
constexpr auto coeffs_for_D = array_of< double >( 0.05, 0.075, 0.1, 0.125, 0.15, 0.2 );
constexpr auto vals_for_E = array_of< int >( 1, 5, 10, 15, 20, 25 );
constexpr auto coeffs_for_F = array_of< double >()
constexpr auto vals_for_G = array_of< int >
constexpr auto coeffs_for_H = array_of< double >
constexpr auto vals_for_I = array_of< int >
constexpr auto coeffs_for_J = array_of< double >
constexpr auto vals_for_K = array_of< int >
constexpr auto coeffs_for_L = array_of< double >
constexpr auto vals_for_M = array_of< int >
constexpr auto coeffs_for_N = array_of< double >
constexpr auto vals_for_O = array_of< int >
constexpr auto coeffs_for_P = array_of< double >
constexpr auto vals_for_Q = array_of< int >
constexpr auto coeffs_for_R = array_of< double >
constexpr auto vals_for_S = array_of< int >
constexpr auto coeffs_for_T = array_of< double >
constexpr auto vals_for_U = array_of< int >
constexpr auto coeffs_for_V = array_of< double >
constexpr auto vals_for_W = array_of< int >
constexpr auto coeffs_for_X = array_of< double >
constexpr auto vals_for_Y = array_of< int >
constexpr auto coeffs_for_Z = array_of< double >( 1.0 );
