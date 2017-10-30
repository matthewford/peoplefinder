module Concerns::FormFieldOptions # rubocop:disable Metrics/ModuleLength
  extend ActiveSupport::Concern

  included do
    WEEK_DAYS = [
      :works_monday,
      :works_tuesday,
      :works_wednesday,
      :works_thursday,
      :works_friday
    ].freeze

    DAYS_WORKED = [
      *WEEK_DAYS,
      :works_saturday,
      :works_sunday
    ].freeze

    def works_weekends?
      works_saturday || works_sunday
    end

    BUILDING_OPTS = [
      :whitehall_55,
      :whitehall_3,
      :victoria_1,
      :horse_guards,
      :king_charles
    ].freeze

    KEY_SKILL_OPTS = %w{
      asset_management
      change_management
      coaching
      commercial_specialist
      commissioning
      contract_management
      credit_risk_analysis
      customer_service
      digital
      digital_workspace_publisher
      economist
      financial_reporting
      graphic_design
      hr
      income_generation
      information_management
      interviewing
      it
      law
      line_management
      media_trained
      mentoring
      policy_design
      policy_implementation
      presenting
      project_delivery
      project_management
      property_estates
      research_operational
      research_economic
      research_statistical
      research_social
      research_user
      security
      skills_and_capability
      sponsorship
      stakeholder_management
      statistics
      strategy
      submission_writing
      talent_management
      tax
      training
      underwriting
      valution
      working_with_devolved_admin
      working_with_ministers
      working_with_govt_depts
    }.freeze

    GRADE_OPTS = %w{
      fco_s1
      fco_s2
      fco_s3
      admin_assistant
      admin_officer
      executive_officer
      higher_executive_officer
      senior_executive_officer
      grade_7
      grade_6
      scs_1
      scs_2
      scs_3
      scs_4
      fast_stream
      fast_track
      apprentice
      non_graded_special_advisor
      non_graded_contractor
      non_graded_secondee
      non_graded_post
    }.freeze

    LEARNING_DEVELOPMENT_OPTS = %w{
      shadowing
      mentoring
      research
      overseas_posts
      secondment
      parliamentary_work
      ministerial_submissions
      coding
    }.freeze

    NETWORK_OPTS = %w{
      age
      disability
      enthnicity
      eu_nationals
      lgbti_plus
      parents
      advisory_group_for_race_equality
      faith_group
      women
      muslim_women
      mentoring
    }.freeze

    KEY_RESPONSIBILITY_OPTS = %w{
      hr_partner
      finance_partner
      scrum_master
      communications
      training
      admin_coordinator
      ministerial_submissions
      webinars
      business_outreach
      communities
      capability_management
      commercial
      knowledge_management
    }.freeze

    ADDITIONAL_RESPONSIBILITY_OPTS = %w{
      fire_warden
      first_aider
      mental_health_first_aider
      mentor
      network_lead
      network_deputy_lead
      union_rep
      cirrus_champion
      health_wellbeing_champion
      fast_stream_rep
      overseas_staff_rep
      digital_champion
      information_manager
    }.freeze
  end
end
