if numinput_countdown_ms != 0 {
	numinput_countdown_ms -= delta_time / 1000
	
	if numinput_countdown_ms < 0 {
		num_repeats = 0
		numinput_countdown_ms = 0
	}
}