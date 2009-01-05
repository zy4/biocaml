(** Parsing of tabular data with named columns. Input files must be in the format below. Columns must be separated by a single tab character and their names must be given on the first line.
    
    {v
    colA     colB     .     colN
    x0A      x0B      .     x0N
     .        .       .      .
     .        .       .      .
     .        .       .      .
    xMA      xMB      .     xMN
    v}
    
*)

type row
    (** Data row. *)
    
type getter = row -> string -> string
  (** A function [get] of type [getter] can be used as [get r c] to get the value of the column named [c] in row [r]. It raises [Failure] if the column name is invalid, or if the given row does not have a value for that column. *)

val make_fold : string -> (getter * (('a -> row -> 'a) -> 'a -> 'a))
  (** [make_fold file] returns a [getter] function and a fold function that can be used for the given [file]. For example, the result of the code below is a list of all the values in column [c].
      {v
      let get,fold = make_fold file in
      let f l r = (get r c)::l in
      List.rev (fold f [])
      v}
      Function [f] should raise [Failure] in case of error. The returned [fold] function will raise [Failure] with information about where the error occurred. Calling [fold] repeatedly will work correctly (assuming the [file] itself does not change between calls).
  *)
  
val make_iter : string -> (getter * ((row -> unit) -> unit))
  (** Like [make_fold] but the function returned is an [iter]ator. *)
  
