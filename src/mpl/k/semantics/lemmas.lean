/-
Copyright (c) 2018 Bruno Bentzen. All rights reserved.
Released under the Apache License 2.0 (see "License");
Author: Bruno Bentzen
-/

import .basic

open classical

variable {σ : nat}

def not_ff_iff_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : (M⦃p⦄w) ≠ ff ⇔ (M⦃p⦄w) = tt := by simp
def not_tt_iff_ff {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : (M⦃p⦄w) ≠ tt ⇔ (M⦃p⦄w) = ff := by simp

/- general facts about non-modal logical constants -/

def neg_tt_iff_ff {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} :
  (M⦃~p⦄w) = tt ⇔ (M⦃p⦄w) = ff :=
by unfold form_tt_in_wrld; induction (form_tt_in_wrld _ M p w); simp; simp

def neg_ff_iff_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} :
  (M⦃~p⦄w) = ff ⇔ (M⦃p⦄w) = tt :=
by unfold form_tt_in_wrld; induction (form_tt_in_wrld _ M p w); simp; simp

def impl_tt_iff_tt_implies_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} :
  (M⦃p ⊃ q⦄w) = tt ⇔ ((M⦃p⦄w) = tt ⇒ (M⦃q⦄w) = tt) :=
by unfold form_tt_in_wrld; induction (form_tt_in_wrld _ M p w); repeat {induction (form_tt_in_wrld _ M q w), simp, simp}

def impl_tt_iff_ff_or_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} :
  (M⦃p ⊃ q⦄w) = tt ⇔ ((M⦃p⦄w) = ff ∨ (M⦃q⦄w) = tt) :=
by unfold form_tt_in_wrld; induction (form_tt_in_wrld _ M p w); repeat {induction (form_tt_in_wrld _ M q w), simp, simp}

def impl_ff_iff_tt_and_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} :
  (M⦃p ⊃ q⦄w) = ff ⇔ ((M⦃p⦄w) = tt ∧ (M⦃q⦄w) = ff) :=
by unfold form_tt_in_wrld; induction (form_tt_in_wrld _ M p w); repeat {induction (form_tt_in_wrld _ M q w), simp, simp}

def ff_or_tt_and_tt_implies_tt_right {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} :
  ((M⦃p⦄w) = ff ∨ (M⦃q⦄w) = tt) ⇒ (M⦃p⦄w) = tt ⇒ (M⦃q⦄w) = tt :=
by unfold form_tt_in_wrld; induction (form_tt_in_wrld _ M p w); repeat {induction (form_tt_in_wrld _ M q w), simp, simp}

def ff_or_tt_and_tt_implies_tt_left {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} :
  ((M⦃p⦄w) = tt ∨ (M⦃q⦄w) = ff) ⇒ (M⦃q⦄w) = tt ⇒ (M⦃p⦄w) = tt :=
by unfold form_tt_in_wrld; induction (form_tt_in_wrld _ M p w); repeat {induction (form_tt_in_wrld _ M q w), simp, simp}

def or_neq_to_or_eq {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} :
  ((M⦃p⦄w) ≠ tt ∨ (M⦃q⦄w) ≠ ff) ⇒ ((M⦃p⦄w) = ff ∨ (M⦃q⦄w) = tt) :=
by induction (form_tt_in_wrld _ M p w); repeat {induction (form_tt_in_wrld _ M q w), simp, simp}

def bot_is_insatisf {w : ctx σ} : 
  ¬ ∃ (M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ), (M⦃⊥⦄ w) = tt :=
by intro h; cases h; exact (bool.no_confusion h_h) 

/- Modal logical constants (=>) -/

def forall_wrld_tt_nec_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (∀ v, w ∈ (𝓦 ▹ M) → v ∈ (𝓦 ▹ M) → (𝓡 ▹ M) w v = tt → (M⦃p⦄v) = tt) ⇒ (M⦃◻p⦄w) = tt := 
begin
  intro h, 
  unfold form_tt_in_wrld,
  induction (prop_decidable _),
    simp, contradiction,
    simp, assumption
end

def exists_wlrd_tt_pos_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (∃ v, w ∈ (𝓦 ▹ M) ∧ v ∈ (𝓦 ▹ M) ∧ (𝓡 ▹ M) w v = tt ∧ (M⦃p⦄v) = tt) ⇒ (M⦃◇p⦄w) = tt := 
begin
  intro h,
  unfold form_tt_in_wrld,
  induction (prop_decidable _),
    simp, intro hf, cases h, cases h_h, cases h_h_right, cases h_h_right_right,
      exact (bool.no_confusion 
        (eq.trans (eq.symm h_h_right_right_right) 
          (hf h_w h_h_left h_h_right_left h_h_right_right_left))),
    simp, intro hf, cases h, cases h_h, cases h_h_right, cases h_h_right_right,
      apply bot_is_insatisf, apply exists.intro, apply impl_tt_iff_tt_implies_tt.1,
        exact (h_1 h_w h_h_left h_h_right_left h_h_right_right_left),
        assumption
end

-- 

/- Modal logical constants (<=) -/

def nec_tt_forall_wrld_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (M⦃◻p⦄w) = tt ⇒ (∀ v, w ∈ (𝓦 ▹ M) → v ∈ (𝓦 ▹ M) → (𝓡 ▹ M) w v = tt → (M⦃p⦄v) = tt) := 
begin
  unfold form_tt_in_wrld,
  induction (prop_decidable _),
    repeat {simp, exact id}
end

def pos_tt_exists_wlrd_tt {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (M⦃◇p⦄w) = tt ⇒ (∃ v, w ∈ (𝓦 ▹ M) ∧ v ∈ (𝓦 ▹ M) ∧ (𝓡 ▹ M) w v = tt ∧ (M⦃p⦄v) = tt) := 
begin
  unfold form_tt_in_wrld,
    simp, intro h, apply by_contradiction, intro hn,
    have nh : ∀ v, w ∈ M.wrlds → v ∈ M.wrlds → M.access w v = tt → _ ≠ tt :=
      begin
        intros v wmem vmem rwv ptt,
        apply hn,
          apply exists.intro,
            apply and.intro,
              assumption, apply and.intro,
                exact vmem, apply and.intro,
                assumption, assumption
      end,
    apply h,
      intros v wmem vmem rwv,
        apply eq_ff_of_not_eq_tt,
          apply nh, repeat {assumption}
end

def pos_ff_forall_wrld_ff {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (M⦃◇p⦄w) = ff ⇒ (∀ v, w ∈ (𝓦 ▹ M) → v ∈ (𝓦 ▹ M) → (𝓡 ▹ M) w v = tt → (M⦃p⦄v) = ff) := 
by unfold form_tt_in_wrld; simp; exact id

/- Some facts about K -/

def nec_impl_to_nec_impl_nec {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} : 
  (M⦃◻(p ⊃ q)⦄w) = tt ⇒ (M⦃◻p⦄w) = tt ⇒ (M⦃◻q⦄w) = tt := 
begin
  unfold form_tt_in_wrld, simp at *, intros hlpq hlp v wmem vmem rwv,
  apply ff_or_tt_and_tt_implies_tt_right,
    apply hlpq, repeat {assumption}, 
    apply hlp, repeat {assumption}, 
end

def nec_impl_ff_exist_wlrd_ff {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} : 
  (M⦃◻(p ⊃ q)⦄ w)= ff ⇒ (∃ v, w ∈ (𝓦 ▹ M) ∧ v ∈ (𝓦 ▹ M) ∧ (𝓡 ▹ M) w v = tt ∧ (M⦃p⦄v) = tt ∧ (M⦃q⦄v) = ff) := 
begin
  unfold form_tt_in_wrld,
  simp, intro h,
    apply by_contradiction, intro hn,
      have nh : ∀ v, ¬ (w ∈ M.wrlds ∧ v ∈ M.wrlds ∧ M.access w v = tt ∧ _ = tt ∧ _ = ff) :=
        begin
          apply forall_not_of_not_exists, exact hn
        end,
      apply h,
        intros v wmem vmem rwv, apply or_neq_to_or_eq, 
          cases ((@decidable.not_and_iff_or_not _ _ (prop_decidable _) (prop_decidable _)).1 (nh v)),
            contradiction,
              cases ((@decidable.not_and_iff_or_not _ _ (prop_decidable _) (prop_decidable _)).1 h_1),
                contradiction,
                cases ((@decidable.not_and_iff_or_not _ _ (prop_decidable _) (prop_decidable _)).1 h_2),
                  contradiction,
                  apply (@decidable.not_and_iff_or_not _ _ (prop_decidable _) (prop_decidable _)).1,
                    assumption
end

def nec_nec_to_nec_impl {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p q : form σ} : 
  (M⦃◻p⦄w) = tt ⇒ (M⦃◻q⦄w) = tt ⇒ (M⦃◻(p ⊃ q)⦄w) = tt  := 
begin
  unfold form_tt_in_wrld, simp at *,
  intros hp hq v wmem vmem rwv,
    apply or.intro_right, apply hq, repeat {assumption}
end

/- context projections -/

def cons_ctx_tt_iff_and {Γ : ctx σ} {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (M⦃(Γ ⸴ p)⦄w) = tt ⇔ (M⦃Γ⦄w) = tt ∧ (M⦃p⦄w) = tt :=
by unfold ctx_tt_in_wrld; induction (ctx_tt_in_wrld _ M Γ w); repeat { induction (form_tt_in_wrld _ M p w), simp, simp }

def cons_ctx_tt_to_ctx_tt {Γ : ctx σ} {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (M⦃(Γ ⸴ p)⦄w) = tt ⇒ (M⦃Γ⦄w) = tt :=
by intro h; apply and.elim_left; apply cons_ctx_tt_iff_and.1 h

def ctx_tt_cons_tt_to_cons_ctx_tt {Γ : ctx σ} {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (M⦃Γ⦄w) = tt ⇒ (M⦃p⦄w) = tt  ⇒ (M⦃(Γ ⸴ p)⦄w) = tt :=
begin
  unfold ctx_tt_in_wrld,
  cases (form_tt_in_wrld _ M p w),
    simp, simp,
  apply id
end

/- more general facts -/ 

def ctx_tt_to_mem_tt {Γ : ctx σ} {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} {p : form σ} : 
  (M⦃Γ⦄w) = tt ⇒ p ∈ Γ ⇒ (M⦃p⦄w) = tt :=
begin
  intros h memp, induction Γ, revert memp, simp,
  cases memp,
    induction memp, apply and.elim_right, apply cons_ctx_tt_iff_and.1 h,
    apply Γ_ih, apply and.elim_left, apply cons_ctx_tt_iff_and.1 h, exact memp
end

def ctx_tt_to_subctx_tt {Γ Δ : ctx σ} {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ} : 
  (M⦃Γ⦄w) = tt ⇒ Δ ⊆ Γ ⇒ (M⦃Δ⦄w) = tt :=
begin
  intros h s,
  induction Δ,
    reflexivity,
    unfold ctx_tt_in_wrld, simp at *, split,
      apply Δ_ih, apply sub_cons_is_sub s,
      apply ctx_tt_to_mem_tt h,
        apply s trivial_mem_left
end

def mem_tt_to_ctx_tt (Γ : ctx σ) {M : (𝓦 ⸴ 𝓡 ⸴ 𝓿) σ} {w : ctx σ}  : 
 (∀ (p : form σ) (h : p ∈ Γ), (M⦃p⦄w) = tt) ⇒ (M⦃Γ⦄w) = tt :=
begin
  intro, induction Γ,
    reflexivity,
    unfold ctx_tt_in_wrld, simp at *, split,
      apply Γ_ih,
        intros p pmem, apply a,
        apply or.intro_right, exact pmem,
      apply a,
        apply or.intro_left, reflexivity  
end

/- the deduction metatheorem -/

def sem_deduction {Γ : ctx σ} {p q : form σ} :
  (Γ ⸴ p ⊨ₖ q) ⇒ (Γ ⊨ₖ p ⊃ q) :=
begin
 intro h,
 cases h,
   apply sem_csq.is_true,
     intros M w ant,
     apply impl_tt_iff_tt_implies_tt.2,
       intro hp, apply h,
         apply ctx_tt_cons_tt_to_cons_ctx_tt,
           repeat {assumption}
end
