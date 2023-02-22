class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, :length => {minimum: 250}
    validates :summary, :length => {maximum: 250}
    validates :category, inclusion: {in: ['Fiction', 'Non-Fiction']}

    validate :validate_clickbaity

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def validate_clickbaity
        # if title.includes? `Won't Believe` || 'Secret' || 'Top [number]' || 'Guess'
        if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
            errors.add(:title, "must be clickbait")
        end
    end
end
