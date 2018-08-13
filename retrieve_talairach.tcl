 proc .. {a {b ""} {step 1}} {
    if {$b eq ""} {set b $a; set a 0} ;# argument shift
    if {![string is int $a] || ![string is int $b]} {
        scan $a %c a; scan $b %c b
        incr b $step ;# let character ranges include the last
        set mode %c
    } else {set mode %d}
    set ss [sgn $step]
    if {[sgn [expr {$b - $a}]] == $ss} {
        set res [format $mode $a]
        while {[sgn [expr {$b-$step-$a}]] == $ss} {
            lappend res [format $mode [incr a $step]]
        }
        set res
    } ;# one-armed if: else return empty list
 }

 proc sgn x {expr {($x>0) - ($x<0)}}

set fp [open "number_of_vertices.txt" r]

set file_data [read $fp]

close $fp

set data [ .. 0 $file_data ]

foreach data_point $data {

  set x [ select_vertex_by_vno $data_point ]
  
  set x [ find_orig_vertex_coordinates ]

}

exit
