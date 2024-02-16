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
let list_add x nums = failwith "unimplemented"
let mold f lst = failwith "unimplemented"
let list_sum_product lst = failwith "unimplemented"

(* records *)
type results = {
  sum_even: int;
  product_odd: int;
  num_elements: int;
}
let record_sum_product lst = failwith "unimplemented"

(* tree variant *)
type 'a tree = 
  | Leaf 
  | Node of 'a tree * 'a * 'a tree

(* variants *)
let rec tree_add x tree = failwith "unimplemented"
let rec tree_preorder tree = failwith "unimplemented"
let rec tree_sum_product tree = failwith "unimplemented"
