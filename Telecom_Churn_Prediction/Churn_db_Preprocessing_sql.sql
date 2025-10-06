use churn_db;


-- Detailed Data Exploration, Counting NULL or BLANK values


select
  sum(case when customer_id is null or customer_id = '' then 1 else 0 end) as customer_id_missing,
  sum(case when gender is null or gender = '' then 1 else 0 end) as gender_missing,
  sum(case when age is null or age = '' then 1 else 0 end) as age_missing,
  sum(case when married is null or married = '' then 1 else 0 end) as married_missing,
  sum(case when state is null or state = '' then 1 else 0 end) as state_missing,
  sum(case when number_of_referrals is null or number_of_referrals = '' then 1 else 0 end) as number_of_referrals_missing,
  sum(case when tenure_in_months is null or tenure_in_months = '' then 1 else 0 end) as tenure_in_months_missing,
  sum(case when value_deal is null or value_deal = '' then 1 else 0 end) as value_deal_missing,
  sum(case when phone_service is null or phone_service = '' then 1 else 0 end) as phone_service_missing,
  sum(case when multiple_lines is null or multiple_lines = '' then 1 else 0 end) as multiple_lines_missing,
  sum(case when internet_service is null or internet_service = '' then 1 else 0 end) as internet_service_missing,
  sum(case when internet_type is null or internet_type = '' then 1 else 0 end) as internet_type_missing,
  sum(case when online_security is null or online_security = '' then 1 else 0 end) as online_security_missing,
  sum(case when online_backup is null or online_backup = '' then 1 else 0 end) as online_backup_missing,
  sum(case when device_protection_plan is null or device_protection_plan = '' then 1 else 0 end) as device_protection_plan_missing,
  sum(case when premium_support is null or premium_support = '' then 1 else 0 end) as premium_support_missing,
  sum(case when streaming_tv is null or streaming_tv = '' then 1 else 0 end) as streaming_tv_missing,
  sum(case when streaming_movies is null or streaming_movies = '' then 1 else 0 end) as streaming_movies_missing,
  sum(case when streaming_music is null or streaming_music = '' then 1 else 0 end) as streaming_music_missing,
  sum(case when unlimited_data is null or unlimited_data = '' then 1 else 0 end) as unlimited_data_missing,
  sum(case when contract is null or contract = '' then 1 else 0 end) as contract_missing,
  sum(case when paperless_billing is null or paperless_billing = '' then 1 else 0 end) as paperless_billing_missing,
  sum(case when payment_method is null or payment_method = '' then 1 else 0 end) as payment_method_missing,
  sum(case when monthly_charge is null or monthly_charge = '' then 1 else 0 end) as monthly_charge_missing,
  sum(case when total_charges is null or total_charges = '' then 1 else 0 end) as total_charges_missing,
  sum(case when total_refunds is null or total_refunds = '' then 1 else 0 end) as total_refunds_missing,
  sum(case when total_extra_data_charges is null or total_extra_data_charges = '' then 1 else 0 end) as total_extra_data_charges_missing,
  sum(case when total_long_distance_charges is null or total_long_distance_charges = '' then 1 else 0 end) as total_long_distance_charges_missing,
  sum(case when total_revenue is null or total_revenue = '' then 1 else 0 end) as total_revenue_missing,
  sum(case when customer_status is null or customer_status = '' then 1 else 0 end) as customer_status_missing,
  sum(case when churn_category is null or churn_category = '' then 1 else 0 end) as churn_category_missing,
  sum(case when churn_reason is null or churn_reason = '' then 1 else 0 end) as churn_reason_missing
from customer_data;


-- Removing NULL or BLANK values


create table prod_churn as
select 
    customer_id,
    gender,
    age,
    married,
    state,
    number_of_referrals,
    tenure_in_months,
    case when value_deal is null or value_deal = '' then 'None' else value_deal end as value_deal,
    phone_service,
    case when multiple_lines is null or multiple_lines = '' then 'No' else multiple_lines end as multiple_lines,
    internet_service,
    case when internet_type is null or internet_type = '' then 'None' else internet_type end as internet_type,
    case when online_security is null or online_security = '' then 'No' else online_security end as online_security,
    case when online_backup is null or online_backup = '' then 'No' else online_backup end as online_backup,
    case when device_protection_plan is null or device_protection_plan = '' then 'No' else device_protection_plan end as device_protection_plan,
    case when premium_support is null or premium_support = '' then 'No' else premium_support end as premium_support,
    case when streaming_tv is null or streaming_tv = '' then 'No' else streaming_tv end as streaming_tv,
    case when streaming_movies is null or streaming_movies = '' then 'No' else streaming_movies end as streaming_movies,
    case when streaming_music is null or streaming_music = '' then 'No' else streaming_music end as streaming_music,
    case when unlimited_data is null or unlimited_data = '' then 'No' else unlimited_data end as unlimited_data,
    contract,
    paperless_billing,
    payment_method,
    monthly_charge,
    total_charges,
    total_refunds,
    total_extra_data_charges,
    total_long_distance_charges,
    total_revenue,
    customer_status,
    case when churn_category is null or churn_category = '' then 'Others' else churn_category end as churn_category,
    case when churn_reason is null or churn_reason = '' then 'Others' else churn_reason end as churn_reason
from customer_data;

select distinct customer_status from prod_churn;


-- Creating Views


create view vw_churndata as
select * from prod_churn
where customer_status in ('Churned', 'Stayed');

create view vw_joindata as
select * from prod_churn
where customer_status = "Joined";

