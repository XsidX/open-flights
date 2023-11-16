import { Route, Routes } from 'react-router-dom';

import Home from '../../pages/index';

const AppRoutes = () => {
    return (
        <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/airlines/:slug" element={<div>airline</div>} />
        </Routes>
    );
    }

export default AppRoutes;