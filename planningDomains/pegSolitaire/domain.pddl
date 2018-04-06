(define (domain PEGSOLITAIRE)
  (:requirements :strips :typing)
  (:types location)
  (:predicates
    (in_line ?x - location ?y - location ?z - location)
    (occupied ?x - location)
    (free ?x - location)
    (move_ended)
    (last_visited ?x - location)
  )

  (:action jump_new_move
    :parameters (?from - location ?over - location ?to - location)
    :precondition (and
                    (move_ended)
                    (in_line ?from ?over ?to)
                    (occupied ?from)
                    (occupied ?over)
                    (free ?to)
                  )
    :effect (and
              (not (move_ended))
              (not (occupied ?from))
              (not (occupied ?over))
              (not (free ?to))
              (free ?from)
              (free ?over)
              (occupied ?to)
              (last_visited ?to)
            )
  )

  (:action jump-continue-move
    :parameters (?from - location ?over - location ?to - location)
    :precondition (and
                    (last_visited ?from)
                    (in_line ?from ?over ?to)
                    (occupied ?from)
                    (occupied ?over)
                    (free ?to)
                  )
    :effect (and
              (not (occupied ?from))
              (not (occupied ?over))
              (not (free ?to))
              (free ?from)
              (free ?over)
              (occupied ?to)
              (not (last_visited ?from))
              (last_visited ?to)
            )
  )

  (:action end-move
    :parameters (?loc - location)
    :precondition (last_visited ?loc)
    :effect (and
              (move_ended)
              (not (last_visited ?loc))
            )
  )
)
