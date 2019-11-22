########
# TIMING

t0 <- Sys.time()

binomial_glm <- glm(depression ~ income, family=binomial, data=clean)

t1 <- Sys.time()
elapsed1 <- t1-t0



##############
# MIXED EFFECT

t0 <- Sys.time()

# ERROR
binomial_lmm <- lme4::glmer(depression ~ income + (1|person_id), family=binomial, data=clean)

t1 <- Sys.time()
elapsed2 <- t1-t0