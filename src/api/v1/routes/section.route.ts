import { Router } from 'express';
import sectionController from '../controllers/section.controller';
import { validateBody } from '../middlewares/schema.middleware';
import { CreateSectionSchema, UpdateSectionSchema } from '../schemas/section.schema';

const sectionRouter = Router({ mergeParams: true });

sectionRouter.get('/', sectionController.getSections);
sectionRouter.get('/:sectionID', sectionController.getSection);
sectionRouter.post('/', validateBody(CreateSectionSchema), sectionController.createSection);
sectionRouter.patch('/:sectionID', validateBody(UpdateSectionSchema), sectionController.updateSection);
sectionRouter.delete('/:sectionID', sectionController.deleteSection);

export default sectionRouter;