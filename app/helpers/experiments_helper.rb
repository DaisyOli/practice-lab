module ExperimentsHelper
  STATUS_BADGES = {
    "idea" => "badge-ghost",
    "prototype" => "badge-info",
    "testing" => "badge-warning",
    "validated" => "badge-success",
    "archived" => "badge-neutral"
  }.freeze

  def experiment_status_badge(experiment)
    tag.span experiment.status.humanize, class: "badge #{STATUS_BADGES.fetch(experiment.status)}"
  end

  # Only experiments that have been built have somewhere to go.
  # Add a mapping here when an experiment gets its own routes.
  def experiment_entry_path(experiment)
    case experiment.slug
    when "dialogue-reconstruction" then dialogues_path
    end
  end
end
