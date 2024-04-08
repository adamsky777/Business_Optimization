def create_shifts(period_length):
    """
    Args:
        period_length: is the horizon's time periods in intervals 15, 30 or 60 min.
        Based on the earliest start time and  min. max. duration we generate a set of shifts.
    Returns: Set of shift with the start time of the interval and duration.

    """
    day_length = 24 * 60 // period_length
    earliest_start = 7 * 60 // period_length
    minimum_duration = 6 * 60 // period_length
    maximum_duration = 10 * 60 // period_length
    shifts = []
    for start_time in range(earliest_start, day_length):
        for duration in range(minimum_duration, maximum_duration):
            shifts.append((start_time, duration))

    for duration in range(minimum_duration, maximum_duration):
        shifts.append((0, duration))

    return shifts


def is_shift_covering_period(shift, period, day_length):
    """
    Args:
        shift: tuple (shift's start time, shift's duration)
        period: to check if shift covers period
        day_length: the length of the horizon.

    Returns: True if shift covers period, False otherwise
    """
    intervals = [(shift[0], min(shift[0] + shift[1], day_length))]

    if shift[0] + shift[1] >= day_length:
        intervals.append((0, shift[0] + shift[1] - day_length))

    for interval in intervals:
        if period >= interval[0] and period < interval[1]:
            return True

    return False

#shifts = create_shifts(30)
#is_shift_covering_period((23, 8), 30, len(shifts))
