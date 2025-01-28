const link_prefix = "https://zeq1568.github.io/files";
const downloads = document.querySelectorAll('download');

function downloadFile(url, filename, progressBar, statusText) {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.responseType = 'blob';

    xhr.onprogress = (event) => {
        if (event.lengthComputable) {
            const percentComplete = (event.loaded / event.total) * 100;
            progressBar.value = percentComplete;
            const elapsedTime = (Date.now() - xhr.startTime) / 1000;
            const averageSpeed = event.loaded / elapsedTime;
            const bytesRemaining = event.total - event.loaded;
            const secondsRemaining = Math.round(bytesRemaining / averageSpeed);
            statusText.textContent = `${Math.round(percentComplete)}% - ${secondsRemaining} seconds remaining`;
        }
    };
    

    xhr.onloadstart = () => {
        xhr.startTime = Date.now();
        progressBar.style.display = 'block';
        statusText.style.display = 'block';
    };

    xhr.onload = () => {
        if (xhr.status === 200) {
            const blob = new Blob([xhr.response]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = filename;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            setTimeout(() => {
                progressBar.style.display = 'none';
                statusText.style.display = 'none';
                progressBar.value = 0;
            }, 500);
        }
    };
    xhr.onerror = () => {
        alert('Download failed. Please try again.');
        progressBar.style.display = 'none';
        statusText.style.display = 'none';
    };
    xhr.send();
}

downloads.forEach(download => {
    const link = download.getAttribute('link');
    const description = download.getAttribute('description');
    const li = document.createElement('li');
    const anchor = document.createElement('a');
    anchor.download = link.split('/').pop();
    anchor.href = link_prefix + link.replace(/ /g, '%20');
    anchor.textContent = link.split('/').pop();
    anchor.style.cursor = 'pointer';
    const progressBar = document.createElement('progress');
    progressBar.max = 100;
    progressBar.value = 0;
    progressBar.style.display = 'none';
    progressBar.style.width = '100%';
    const statusText = document.createElement('span');
    statusText.style.display = 'none';
    statusText.style.marginLeft = '10px';
    anchor.addEventListener('click', (e) => {
       e.preventDefault();
       const filename = link.split('/').pop();
       downloadFile(anchor.href, filename, progressBar, statusText);
    });
    const br = document.createElement('br');
    const small = document.createElement('small');
    small.textContent = description;
    li.appendChild(anchor);
    li.appendChild(br);
    li.appendChild(progressBar);
    li.appendChild(statusText);
    li.appendChild(small);
    download.replaceWith(li);
    li.insertAdjacentHTML('afterend', '<br>');
});
