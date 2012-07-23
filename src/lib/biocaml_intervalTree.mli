(** Interval tree (data structure)
    
    An interval tree is a collection of integer-bounded intervals labeled by a
    value.

    For a brief description of the implementation, see {{:http://en.wikipedia.org/wiki/Interval_tree#Augmented_tree}the matching Wikipedia article}

*)

type 'a t

exception Empty_tree

(** {6 Accessors} *)

val is_empty : 'a t -> bool

val cardinal : 'a t -> int

val intersects : int -> int -> 'a t -> bool
(** [intersects a b t] returns [true] if one interval in [t]
    intersects with the interval \[[a];[b]\].*)


(** {6 Constructors} *)

val empty : 'a t
(** the empty tree *)

val add : int -> int -> 'a -> 'a t -> 'a t
(** [add lo hi v t] adds the interval ([lo], [hi]) labeled with value
    [v] to the contents of [t]. Note that in contrast to sets,
    identical intervals (even with identical labels) may be *repeated*
    in an interval tree. E.g., [add 1 2 () (add 1 2 ())] contains 2
    intervals. *)


(** {6 Conversion} *)

val elements : 'a t -> (int * int * 'a) list

val enum : 'a t -> (int * int * 'a) BatEnum.t

val backwards : 'a t -> (int * int * 'a) BatEnum.t


(** {6 Searching and filtering} *)

val find_closest : int -> int -> 'a t -> int * int * 'a * int
(** [find_closest lo hi t] returns the interval in [t] which is at
    minimal distance of the interval \[[lo];[hi]\]. The resulting
    tuple contains from left to right, left-end of the interval,
    right-end of the interval, value associated to the interval and
    distance to the interval given in argument. Overlapping intervals
    are at distance 0 of each other.

    Raises [Empty_tree] if [t] is empty *)

val find_intersecting_elem : int -> int -> 'a t -> (int * int * 'a) BatEnum.t
(** [find_intersecting_elem a b t] is equivalent to [Enum.filter (fun
    (x,y,_) -> intersects x y t) (enum t)] but is more efficient. *)


(** {6 Misc} *)

val print : 'a t -> unit
(** Used for debugging purpose, should be removed in the long run *)

val check_integrity : 'a t -> unit
(** Used for debugging purpose, should be removed in the long run *)









