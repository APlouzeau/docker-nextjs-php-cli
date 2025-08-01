export interface LessonProps {
    id_lesson: number;
    title: string;
    shortDescription: string;
    imagePath: string;
    slug: string;
}
export type lessons = LessonProps[];

export interface Lesson {
    title: string;
    fullDescription: string;
    imagePath: string;
    slug: string;
    times: [
        {
            duration: number;
            price: number;
        }
    ];
}
export type allLessons = Lesson[];

export interface LessonWithPrice {
    idLesson: number;
    title: string;
    shortDescription: string;
    imagePath: string;
    slug: string;
    price: [{ price: number; duration: number }];
    popular: false;
}
export type LessonsWithPrices = LessonWithPrice[];

export interface DetailedOffer {
    imagePath: string;
    title: string;
    description: string;
    price: number;
    duration: number;
    slug: string;
    popular: boolean;
}
export type detailedOffers = DetailedOffer[];
