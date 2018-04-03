(define (domain TOWERS)
  (:requirements :strips :typing)
  (:types tower disk)
  (:predicates
    (empty_tower ?t - tower)
    (disk_on_top_of_tower ?x - disk ?t - tower) ;; ?x is on ?t
    (bigger_disk ?x - disk ?y - disk) ;; ?x is bigger than ?y
    (last_disk ?x - disk) ;; ?x is the only disk on ?t
    (under_disk ?x - disk ?y - disk) ;; ?x is under ?y
    (hand_empty)
    (holding_disk ?x - disk)
  )

  (:action pick_up_last
    :parameters (?x - disk ?t - tower)
    :precondition (and
                    (disk_on_top_of_tower ?x ?t)
                    (last_disk ?x)
                    (hand_empty)
                  )
    :effect (and
              (not (last_disk ?x))
              (not (disk_on_top_of_tower ?x ?t))
              (empty_tower ?t)
              (not (hand_empty))
              (holding_disk ?x)
            )
  )

  (:action pick_up
    :parameters (?x - disk ?y - disk ?t - tower)
    :precondition (and
                    (disk_on_top_of_tower ?x ?t)
                    (under_disk ?y ?x)
                    (hand_empty)
                  )
    :effect (and
              (not (disk_on_top_of_tower ?x ?t))
              (not (under_disk ?y ?x))
              (not (hand_empty))
              (disk_on_top_of_tower ?y ?t)
              (holding_disk ?x)
            )
  )


  (:action put_first
    :parameters (?x - disk ?t - tower)
    :precondition (and
                    (holding_disk ?x)
                    (empty_tower ?t)
                  )
    :effect (and
              (not (holding_disk ?x))
              (not (empty_tower ?t))
              (hand_empty)
              (disk_on_top_of_tower ?x ?t)
              (last_disk ?x)
            )
  )

  (:action put
    :parameters (?x - disk ?y - disk ?t - tower)
    :precondition (and
                    (holding_disk ?x)
                    (disk_on_top_of_tower ?y ?t)
                    (bigger_disk ?y ?x)
                  )
    :effect (and
              (not (holding_disk ?x))
              (hand_empty)
              (disk_on_top_of_tower ?x ?t)
              (not (disk_on_top_of_tower ?y ?t))
              (under_disk ?y ?x)
            )
  )
)
