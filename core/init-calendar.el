;;; init-calendar.el --- Initialize calendar configurations.  -*- lexical-binding: t; -*-

;; Copyright (C) 2019  roife

;; Author: roife <roife@outlook.com>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(eval-when-compile (require 'init-define))
;; Chinese calendar
;; `pC' can show lunar details
(use-package cal-china-x
  :after calendar
  :commands cal-china-x-setup
  :init (cal-china-x-setup)
  :config
  ;; `S' can show the time of sunrise and sunset on Calendar
  ;; TODO 不要显示星座
  (defun cal-china-x-chinese-date-string (date)
    (let* ((cn-date (calendar-chinese-from-absolute
                     (calendar-absolute-from-gregorian date)))
           (cn-year  (cadr   cn-date))
           (cn-month (cl-caddr  cn-date))
           (cn-day   (cl-cadddr cn-date)))
      (format "%s%s年%s%s%s%s"
              (calendar-chinese-sexagesimal-name cn-year)
              (aref cal-china-x-zodiac-name (% (1- cn-year) 12))
              (aref cal-china-x-month-name (1-  (floor cn-month)))
              (if (integerp cn-month) "" "(闰月)")
              (aref cal-china-x-day-name (1- cn-day))
                                        ;(cal-china-x-get-horoscope (car date) (cadr date))
              (cal-china-x-get-solar-term date))))

  (setq calendar-location-name "Hangzhou"
        calendar-latitude 30.67
        calendar-longitude 104.06)

  ;; Holidays
  (setq calendar-mark-holidays-flag t)

  (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
  (setq cal-china-x-general-holidays
        '((holiday-lunar 1 15 "元宵节")
          (holiday-lunar 7 7 "七夕节")
          (holiday-fixed 3 8 "妇女节")
          (holiday-fixed 3 12 "植树节")
          (holiday-fixed 5 4 "青年节")
          (holiday-fixed 6 1 "儿童节")
          (holiday-fixed 9 10 "教师节")))
  (setq holiday-other-holidays
        '((holiday-fixed 2 14 "情人节")
          (holiday-fixed 4 1 "愚人节")
          (holiday-fixed 12 25 "圣诞节")
          (holiday-float 5 0 2 "母亲节")
          (holiday-float 6 0 3 "父亲节")
          (holiday-float 11 4 4 "感恩节")))
  (setq calendar-holidays
        (append cal-china-x-important-holidays
                cal-china-x-general-holidays
                holiday-other-holidays)))

;; Better views of calendar
(use-package calfw
  :commands cfw:open-calendar-buffer
  :init
  (use-package calfw-org
    :commands (cfw:open-org-calendar cfw:org-create-source))

  (use-package calfw-ical
    :commands (cfw:open-ical-calendar cfw:ical-create-source))

  (defun open-calendar ()
    "Open calendar."
    (interactive)
    (unless (ignore-errors
              (cfw:open-calendar-buffer
               :contents-sources
               (list
                (when org-agenda-files
                  (cfw:org-create-source "YellowGreen"))
                (when (bound-and-true-p centaur-ical)
                  (cfw:ical-create-source "gcal" centaur-ical "IndianRed")))))
      (cfw:open-calendar-buffer)))
  (defalias 'centaur-open-calendar 'open-calendar))

(provide 'init-calendar)
;;; init-calendar.el ends here
