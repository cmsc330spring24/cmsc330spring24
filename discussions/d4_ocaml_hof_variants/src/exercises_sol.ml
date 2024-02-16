(* hof helpers *)
let rec map f xs =
  match xs with
    | [] -> []
    | h::t -> (f h)::(map f t)

let rec fold f a lst =
  match lst with
    | [] -> a
    | h::t -> fold f (f a h) t

let rec fold_right f lst a =
  match lst with
    | [] -> a
    | h::t -> f h (fold_right f t a)

(* hofs *)
let list_add x nums = map (fun num -> num + x) nums
let list_add x nums = map ((+) x) nums (* funnier version *)

let mold f lst = List.rev (fold (fun a x -> (f x)::a) [] lst)
let mold f lst = fold (fun a x -> a @ [(f x)]) [] lst
let mold f lst = fold_right (fun x a -> (f x)::a) lst []

let list_sum_product lst = 
  let (sum, product, index) = fold 
    (fun (even, odd, i) num -> 
      if i mod 2 = 0 
        then (even + num, odd, i + 1) 
        else (even, odd * num, i + 1)) 
    (0, 1, 0) lst 
  in (sum, product, sum = product);;

(* records *)
type results = {
  sum_even: int;
  product_odd: int;
  num_elements: int;
}

let record_sum_product lst = 
  fold (fun {sum_even; product_odd; num_elements} num -> 
    if num_elements mod 2 = 0 
      then {
        sum_even = sum_even + num; 
        product_odd; 
        num_elements = num_elements + 1 } 
      else {
        sum_even; 
        product_odd = product_odd * num; 
        num_elements = num_elements + 1 })
  {sum_even = 0; product_odd = 1; num_elements = 0} lst;;

(* tree variant *)
type 'a tree = 
  | Leaf 
  | Node of 'a tree * 'a * 'a tree

(* variants *)
let rec tree_add x tree = match tree with
  | Leaf -> Leaf
  | Node(l, v, r) -> Node(tree_add x l, v + x, tree_add x r)

let rec tree_preorder tree = match tree with
  | Leaf -> ""
  | Node(l, v, r) -> v ^ (tree_preorder l) ^ (tree_preorder r);;

let rec tree_sum_product tree = 
  match tree with
  | Leaf -> (0, 1)
  | Node(l, v, r) -> 
    let (lsum, lproduct) = tree_sum_product l in
    let (rsum, rproduct) = tree_sum_product r in
    (lsum + v + rsum, lproduct * v * rproduct)
