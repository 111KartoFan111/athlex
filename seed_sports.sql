INSERT INTO sports (name, category, icon_url) VALUES 
('Calisthenics', 'Strength', 'fitness_center'),
('Running', 'Cardio', 'directions_run'),
('Cycling', 'Cardio', 'directions_bike'),
('Weightlifting', 'Strength', 'fitness_center'),
('Swimming', 'Cardio', 'pool'),
('Yoga', 'Flexibility', 'self_improvement'),
('Boxing', 'Combat', 'sports_mma'),
('CrossFit', 'Mixed', 'fitness_center')
ON CONFLICT (name) DO NOTHING;
