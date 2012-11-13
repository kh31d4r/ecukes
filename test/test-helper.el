(defmacro with-steps (&rest body)
  `(let ((ecukes-steps-definitions))
     ,@body))

(defun mock-step (name)
  (let ((body (nth 2 (s-match ecukes-parse-step-re name))))
    (make-ecukes-step :name name :body body :type 'regular)))

(defun with-parse-step (name fn)
  (let* ((feature-file (fixture-file-path "step" name))
         (feature (ecukes-parse-feature feature-file))
         (scenarios (ecukes-feature-scenarios feature))
         (scenario (car scenarios))
         (steps (ecukes-scenario-steps scenario))
         (step (car steps))
         (name (ecukes-step-name step))
         (body (ecukes-step-body step))
         (type (ecukes-step-type step))
         (arg (ecukes-step-arg step)))
    (funcall fn name body type arg)))

(defun with-parse-scenario (name fn)
  (let* ((feature-file (fixture-file-path "scenario" name))
         (feature (ecukes-parse-feature feature-file))
         (scenarios (ecukes-feature-scenarios feature))
         (scenario (car scenarios))
         (name) (step-names) (tags))
    (condition-case err
        (progn
          (setq name (ecukes-scenario-name scenario))
          (setq step-names (mapcar 'ecukes-step-name (ecukes-scenario-steps scenario)))
          (setq tags (ecukes-scenario-tags scenario)))
      (error))
    (funcall fn scenario name step-names tags)))

(defun fixture-file-path (category name)
  (let ((category-path (expand-file-name category ecukes-fixtures-path)))
    (expand-file-name (format "%s.feature" name) category-path)))
