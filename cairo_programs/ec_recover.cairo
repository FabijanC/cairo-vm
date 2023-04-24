%builtins range_check
from starkware.cairo.common.cairo_secp.bigint import BigInt3, nondet_bigint3

func test_div_mod_n_packed_hint{range_check_ptr: felt}() {

    tempvar n = BigInt3(177, 0, 0);
    tempvar x = BigInt3(25, 0, 0);
    tempvar s = BigInt3(5, 0, 0);
    %{
        from starkware.cairo.common.cairo_secp.secp_utils import pack
        from starkware.python.math_utils import div_mod, safe_div

        N = pack(ids.n, PRIME)
        x = pack(ids.x, PRIME) % N
        s = pack(ids.s, PRIME) % N
        value = res = div_mod(x, s, N)
    %}

    let (res) = nondet_bigint3();
    assert res = BigInt3(5,0,0);
    return();
}

func main{range_check_ptr: felt}() {
    test_div_mod_n_packed_hint();
    return();
}