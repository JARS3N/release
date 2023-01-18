gen_spec_test <- function(Z) {
  list(
    (function(u) {
      u > Z$LOW_LED && u < Z$pH_LED_high
    }),
    (function(u) {
      u < 30
    }),
    (function(u) {
      j <- Z$gain * c(.9, 1.1)
      u >= j[1] && j <= j[2]
    }),
    (function(u) {
      u < 5
    }),
    (function(u) {
      u > Z$LOW_LED && u < Z$O2_LED_high
    }),
    (function(u) {
      u < 30
    }),
    (function(u) {
      j <- Z$ksv * c(.9, 1.1)
      u >= j[1] && j <= j[2]
    }),
    (function(u) {
      u < 5
    })
  )
}
