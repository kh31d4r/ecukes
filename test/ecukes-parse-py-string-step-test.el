(ert-deftest parse-py-string-step-all-good ()
  (let* ((step (ecukes-test-parse-feature-step "py-string-all-good.feature"))
         (arg (ecukes-step-arg step))
         (split (split-string arg "\n")))
    (should (equal "Given this text:" (ecukes-step-name step)))
    (should (equal "Lorem ipsum dolor sit amet." (nth 0 split)))
    (should (equal "Curabitur pellentesque iaculis eros." (nth 1 split)))
    (should-be-py-string-step step)))

(ert-deftest parse-py-string-step-whitespace ()
  (let* ((step (ecukes-test-parse-feature-step "py-string-whitespace.feature"))
        (arg (ecukes-step-arg step))
        (split (split-string arg "\n")))
    (should (equal "Given this text:" (ecukes-step-name step)))
    (should (equal "Lorem ipsum dolor sit amet." (nth 0 split)))
    (should (equal "" (nth 1 split)))
    (should (equal "In congue. Curabitur pellentesque iaculis eros." (nth 2 split)))
    (should-be-py-string-step step)))

(ert-deftest parse-py-string-step-wrong-indentation ()
  (let* ((step (ecukes-test-parse-feature-step "py-string-wrong-indentation.feature"))
         (arg (ecukes-step-arg step))
         (split (split-string arg "\n")))
    (should (equal "Given this text:" (ecukes-step-name step)))
    (should (equal "Lorem ipsum dolor sit amet." (nth 0 split)))
    (should (equal "       Curabitur pellentesque iaculis eros." (nth 1 split)))
    (should-be-py-string-step step)))
