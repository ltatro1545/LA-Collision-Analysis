CREATE TABLE victims (
    case_id int   NOT NULL,
    party_number int   NOT NULL,
    victim_number int   NOT NULL,
    victim_role int   NOT NULL,
    victim_sex varchar(4)   NOT NULL,
    victim_age int   NOT NULL,
    victim_degree_of_injury int   NOT NULL,
    victim_seating_postion varchar(4)   NOT NULL,
    victim_safety_equip_1 varchar(4)   NOT NULL,
    victim_safety_equip_2 varchar(4)   NOT NULL,
    victim_ejected varchar(4)   NOT NULL,
    county varchar(20)   NOT NULL,
    city varchar(20)   NOT NULL,
    accident_year int   NOT NULL,
    safety_equip_used varchar(4) NOT NULL,
    severe_injury int NOT NULL,
    party_id int NOT NULL
);

CREATE TABLE parties (
    party_id int NOT NULL, 
    case_id int NOT NULL, 
    party_number int NOT NULL, 
    party_type varchar(4) NOT NULL,
    at_fault varchar(4)  NOT NULL,
    party_sex varchar(4)   NOT NULL,
    party_age int   NOT NULL,
    party_soberiety varchar(4)   NOT NULL,
    dir_of_travel varchar(4)   NOT NULL,
    party_safety_equip_1 varchar(4)   NOT NULL,
    party_safety_equip_2 varchar(4)   NOT NULL,
    oaf_1 varchar(4) NOT NULL,
    party_number_killed int   NOT NULL,
    party_number_injured int   NOT NULL,
    move_pre_acc varchar(4)   NOT NULL,
    vehicle_year int   NOT NULL,
    vehicle_make varchar(40)   NOT NULL,
    stwd_vehicle_type varchar(4)   NOT NULL,
    race varchar(4)   NOT NULL,
    accident_year int   NOT NULL,
    safety_equip_used varchar(4) NOT NULL,
    CONSTRAINT pk_parties PRIMARY KEY (
        party_id
     )
);

CREATE TABLE crashes (
    case_id int   NOT NULL,
    accident_year int   NOT NULL,
    collision_time int   NOT NULL,
    day_of_week int   NOT NULL,
    weather_1 varchar(4)   NOT NULL,
    tow_away varchar(4)   NOT NULL,
    collision_severity int   NOT NULL,
    number_killed int   NOT NULL,
    number_injured int   NOT NULL,
    party_count int   NOT NULL,
    primary_coll_factor varchar(4)   NOT NULL,
    pcf_viol_category varchar(4)   NOT NULL,
    hit_and_run varchar(4)   NOT NULL,
    type_of_collision varchar(4)   NOT NULL,
    mviw varchar(4)   NOT NULL,
    road_surface varchar(4)   NOT NULL,
    road_cond_1 varchar(4)   NOT NULL,
    lighting varchar(4)   NOT NULL,
    control_device varchar(4)   NOT NULL,
    pedestrian_accident int   NOT NULL,
    bicycle_accident int   NOT NULL,
    motorcycle_accident int   NOT NULL,
    truck_accident int   NOT NULL,
    not_private_property varchar(4)   NOT NULL,
    alcohol_involved int   NOT NULL,
    stwd_vehtype_at_fault varchar(4)   NOT NULL,
    count_severe_inj int   NOT NULL,
    count_visible_inj int   NOT NULL,
    count_complaint_pain int   NOT NULL,
    count_ped_killed int   NOT NULL,
    count_ped_injury int   NOT NULL,
    count_bicyclist_killed int   NOT NULL,
    count_bicyclist_injured int   NOT NULL,
    count_mc_killed int   NOT NULL,
    count_mc_injured int   NOT NULL,
    point_x float   NOT NULL,
    point_y float   NOT NULL,
    CONSTRAINT pk_crashes PRIMARY KEY (
        case_id
     )
);

ALTER TABLE victims ADD CONSTRAINT fk_victims_case_id FOREIGN KEY(party_id)
REFERENCES parties (party_id);

ALTER TABLE parties ADD CONSTRAINT fk_parties_case_id FOREIGN KEY(case_id)
REFERENCES crashes (case_id);

CREATE TABLE collision_data_ml AS
	SELECT crashes.accident_year, crashes.collision_time, crashes.day_of_week,
	crashes.weather_1, crashes.primary_coll_factor, crashes.type_of_collision,
	crashes.road_surface, crashes.road_cond_1, crashes.lighting, crashes.point_x, crashes.point_y,
	parties.party_number, parties.at_fault, parties.party_sex, parties.party_age, parties.party_soberiety,
	parties.party_safety_equip_1, parties.party_safety_equip_2, parties.oaf_1, parties.party_number_killed,
	parties.party_number_injured, parties.move_pre_acc, parties.vehicle_year, parties.vehicle_make, 
	parties.stwd_vehicle_type, parties.race
	FROM parties
	INNER JOIN crashes
	ON parties.case_id = crashes.case_id;

SELECT * FROM collision_data_ml