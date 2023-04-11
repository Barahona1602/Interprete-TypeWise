import React, { ChangeEvent, useState, useRef } from 'react';

function App() {
  const [fileContent, setFileContent] = useState('');
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileLoad = (event: ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) {
      return;
    }

    const reader = new FileReader();
    reader.onload = (e) => {
      const contents = e.target?.result as string;
      setFileContent(contents);
    };
    reader.readAsText(file);
  };

  const handleOpenClick = () => {
    if (fileInputRef.current) {
      fileInputRef.current.click();
    }
  };

  const handleChange = (event: ChangeEvent<HTMLTextAreaElement>) => {
    // handle textarea changes here
  };

  return (
    <div>
      <nav className="navbar navbar-expand-lg navbar-light bg-light">
        <a className="navbar-brand" href="#">
          TypeWise
        </a>
        <button
          className="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarNav"
          aria-controls="navbarNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon"></span>
        </button>
        <div className="collapse navbar-collapse" id="navbarNav">
          <ul className="navbar-nav">
            <li className="nav-item active">
              <a className="nav-link" href="#">
                Home
              </a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="#">
                Page 1
              </a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="#">
                Page 2
              </a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="#">
                Page 3
              </a>
            </li>
          </ul>
        </div>
      </nav>
      <div className="container-fluid">
        <div className="row">
          <div className="col-12">
          <button className="btn btn-primary mt-3" onClick={handleOpenClick}>
                Abrir
              </button>
              <input
                type="file"
                accept=".tw"
                onChange={handleFileLoad}
                ref={fileInputRef}
                hidden
              />
          <button className="btn btn-primary mt-3" onClick={handleOpenClick}>
                Abrir
              </button>
              <input
                type="file"
                accept=".tw"
                onChange={handleFileLoad}
                ref={fileInputRef}
                hidden
              />
          </div>
          <div className="col-6">
            <div className="form-group">
              <label htmlFor="left-textarea">Entrada</label>
              <textarea
                className="form-control"
                id="left-textarea"
                name="left-textarea"
                rows={5}
                value={fileContent}
                onChange={handleChange}
              ></textarea>
              
            </div>
          </div>
          <div className="col-6">
            <div className="form-group">
              <label htmlFor="right-textarea">Salida</label>
              <textarea
                className="form-control"
                id="right-textarea"
                name="right-textarea"
                rows={5}
                onChange={handleChange}
              ></textarea>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
