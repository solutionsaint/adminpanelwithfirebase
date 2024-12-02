export interface SuggestionModel {
  id: string;
  name: string;
  isApproved: boolean;
  image: string;
  isRejected: boolean;
  tag: string[];
  newTags?: string[];
  isVerified: boolean;
}
